# -*- coding: utf-8 -*-
import argparse
from pathlib import Path

import cv2
import numpy as np


def main():
    parser = argparse.ArgumentParser(description="增强签名字迹，输出 PNG")
    parser.add_argument("input", help="输入图片")
    parser.add_argument("output", help="输出 PNG 图片")
    parser.add_argument(
        "--rotate",
        choices=["cw", "ccw", "180"],
        help="cw：顺时针90度；ccw：逆时针90度；180：旋转180度",
    )
    parser.add_argument("--bw", action="store_true", help="输出纯黑白图片")
    parser.add_argument(
        "--threshold", type=int, default=200,
        help="纯黑白阈值，越大保留的浅色笔画越多，默认200",
    )
    parser.add_argument(
        "--black", type=int, default=80,
        help="灰度模式下，低于此值变为纯黑，默认80",
    )
    parser.add_argument(
        "--white", type=int, default=220,
        help="灰度模式下，高于此值变为纯白，默认220",
    )
    parser.add_argument("--bold", action="store_true", help="轻微加粗笔画")
    args = parser.parse_args()

    if Path(args.output).suffix.lower() != ".png":
        parser.error("输出文件必须使用 .png 后缀")
    if not 0 <= args.threshold <= 255:
        parser.error("--threshold 必须在 0～255 之间")
    if not 0 <= args.black < args.white <= 255:
        parser.error("必须满足 0 <= black < white <= 255")

    # 忽略图片方向元数据，通过 --rotate 明确指定旋转
    image = cv2.imread(
        args.input,
        cv2.IMREAD_GRAYSCALE | cv2.IMREAD_IGNORE_ORIENTATION,
    )
    if image is None:
        raise SystemExit(f"无法读取图片：{args.input}")

    rotations = {
        "cw": cv2.ROTATE_90_CLOCKWISE,
        "ccw": cv2.ROTATE_90_COUNTERCLOCKWISE,
        "180": cv2.ROTATE_180,
    }
    if args.rotate:
        image = cv2.rotate(image, rotations[args.rotate])

    if args.bw:
        _, result = cv2.threshold(
            image, args.threshold, 255, cv2.THRESH_BINARY
        )
    else:
        # 增强对比度，同时保留笔画边缘的灰度过渡
        result = np.clip(
            (image.astype(np.float32) - args.black)
            * 255.0 / (args.white - args.black),
            0, 255,
        ).astype(np.uint8)

    if args.bold:
        # 腐蚀白色区域，让黑色笔画略微加粗
        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (2, 2))
        result = cv2.erode(result, kernel, iterations=1)

    if not cv2.imwrite(args.output, result):
        raise SystemExit(f"保存失败：{args.output}")

    print(f"已保存：{args.output}")


if __name__ == "__main__":
    main()