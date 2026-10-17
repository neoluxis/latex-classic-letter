% !TeX encoding = UTF-8
% 使用 XeLaTeX 编译调用本类的 .tex 文件。

\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\ProvidesClass{classicletter}[2026/10/16 Classical Chinese letter]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[12pt,a4paper,fontset=fandol]{ctexart}

\RequirePackage[
    top=3.8cm,
    bottom=3.8cm,
    left=3.0cm,
    right=3.0cm
]{geometry}

\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\usetikzlibrary{calc}

% ---------- 字体 ----------
\setmainfont{Times New Roman}
\AtBeginDocument{\songti}

% ---------- 中文日期 ----------
\ctexset{today=big}

% ---------- 颜色 ----------
\definecolor{ink}{HTML}{342E29}
\definecolor{gold}{HTML}{94774D}
\definecolor{palegold}{HTML}{CAB994}

\AtBeginDocument{\color{ink}}

% ---------- 排版 ----------
\pagestyle{empty}
\setlength{\parindent}{2em}
\setlength{\parskip}{0.65em}
\linespread{1.6}

% ---------- 默认信息 ----------
\newcommand{\recipient}{尊敬的某某}
\newcommand{\sender}{某某}
\newcommand{\letterdate}{\today}
\newcommand{\signaturefile}{signature.png}

% 设为空可隐藏对应文字
\newcommand{\letterclosingprefix}{此致}
\newcommand{\letterclosingtext}{敬礼！}

% ---------- 配置接口 ----------
\pgfkeys{
    /classicletter/.is family,
    /classicletter,
    recipient/.store in=\recipient,
    sender/.store in=\sender,
    date/.store in=\letterdate,
    signature/.store in=\signaturefile,
    closing prefix/.store in=\letterclosingprefix,
    closing text/.store in=\letterclosingtext
}

\newcommand{\lettersetup}[1]{%
    \pgfkeys{/classicletter,#1}%
}

% ---------- 角部卷草纹 ----------
\newcommand{\cornerornament}{%
    \begin{scope}[
        x=1cm,y=1cm,
        draw=gold,
        line width=0.55pt,
        line cap=round,
        line join=round
    ]
        \draw (0,1.65) -- (0,0) -- (1.65,0);
        \draw (0.13,1.18) -- (0.13,0.13) -- (1.18,0.13);

        \draw (0.20,0.20)
            .. controls (0.45,0.27) and (0.68,0.47) .. (0.70,0.77)
            .. controls (0.74,1.12) and (0.42,1.28) .. (0.30,1.05)
            .. controls (0.20,0.84) and (0.49,0.74) .. (0.51,0.94);

        \draw (0.20,0.20)
            .. controls (0.27,0.45) and (0.47,0.68) .. (0.77,0.70)
            .. controls (1.12,0.74) and (1.28,0.42) .. (1.05,0.30)
            .. controls (0.84,0.20) and (0.74,0.49) .. (0.94,0.51);

        \draw (0.24,0.24)
            .. controls (0.70,0.64) and (1.05,1.05) .. (1.35,1.35);

        \draw[fill=palegold!35]
            (0.62,0.62)
            .. controls (0.43,0.76) and (0.46,0.96) .. (0.48,1.02)
            .. controls (0.67,0.91) and (0.73,0.76) .. (0.62,0.62);

        \draw[fill=palegold!35]
            (0.82,0.82)
            .. controls (0.97,0.65) and (1.17,0.70) .. (1.23,0.72)
            .. controls (1.09,0.89) and (0.96,0.95) .. (0.82,0.82);

        \draw[fill=palegold!35]
            (1.10,1.10)
            .. controls (0.96,1.28) and (1.06,1.45) .. (1.10,1.50)
            .. controls (1.25,1.34) and (1.25,1.21) .. (1.10,1.10);

        \fill
            (1.37,1.30) -- (1.44,1.37) --
            (1.37,1.44) -- (1.30,1.37) -- cycle;
    \end{scope}%
}

% ---------- 每页边框 ----------
\AddToHook{shipout/background}{%
    \begin{tikzpicture}[remember picture,overlay]
        \draw[gold,line width=0.65pt]
            ($(current page.north west)+(1.5cm,-1.5cm)$)
            rectangle
            ($(current page.south east)+(-1.5cm,1.5cm)$);

        \draw[palegold,line width=0.25pt]
            ($(current page.north west)+(1.68cm,-1.68cm)$)
            rectangle
            ($(current page.south east)+(-1.68cm,1.68cm)$);

        \begin{scope}[
            shift={($(current page.south west)+(1.82cm,1.82cm)$)}
        ]
            \cornerornament
        \end{scope}

        \begin{scope}[
            shift={($(current page.south east)+(-1.82cm,1.82cm)$)},
            rotate=90
        ]
            \cornerornament
        \end{scope}

        \begin{scope}[
            shift={($(current page.north east)+(-1.82cm,-1.82cm)$)},
            rotate=180
        ]
            \cornerornament
        \end{scope}

        \begin{scope}[
            shift={($(current page.north west)+(1.82cm,-1.82cm)$)},
            rotate=270
        ]
            \cornerornament
        \end{scope}
    \end{tikzpicture}%
}

% ---------- 对称花饰 ----------
\newcommand{\flourish}{%
    \begin{tikzpicture}[
        x=1cm,y=1cm,
        draw=gold,
        line width=0.55pt,
        line cap=round,
        baseline=0
    ]
        \foreach \s in {-1,1}{
            \begin{scope}[xscale=\s]
                \draw (0.12,0)
                    .. controls (0.48,0.40) and (1.04,0.39) .. (1.32,0.10)
                    .. controls (1.58,-0.19) and (1.98,-0.15) .. (1.96,0.12)
                    .. controls (1.94,0.37) and (1.56,0.32) .. (1.68,0.10);

                \draw (0.45,0.22)
                    .. controls (0.62,0.64) and (1.13,0.68) .. (1.28,0.40)
                    .. controls (1.39,0.19) and (1.08,0.17) .. (1.13,0.36);

                \draw (0.68,0.29)
                    .. controls (0.98,-0.33) and (1.60,-0.43) .. (2.18,-0.12);

                \draw (1.95,0.06) -- (2.65,0.06);

                \draw[fill=palegold!40]
                    (2.20,0.06)
                    .. controls (2.36,0.28) and (2.52,0.26) .. (2.62,0.25)
                    .. controls (2.52,0.09) and (2.36,0.02) .. (2.20,0.06);
            \end{scope}
        }

        \draw[fill=palegold!45]
            (0,0.16) -- (0.11,0) --
            (0,-0.16) -- (-0.11,0) -- cycle;
    \end{tikzpicture}%
}

% ---------- 装饰首字 ----------
\newcommand{\initial}[1]{%
    \tikz[baseline=(char.base)]{
        \node[
            draw=gold,
            double=palegold,
            double distance=1.5pt,
            line width=0.35pt,
            inner sep=5pt,
            text=ink,
            font=\Large\kaishu
        ] (char) {#1};
    }%
}

% ---------- 开头 ----------
\newcommand{\makeletteropening}{%
    {\centering
        \flourish\par
    }

    \vspace{1.6em}

    {\noindent\Large\kaishu \recipient：\par}

    \vspace{0.4em}
}

% ---------- 结尾 ----------
\newcommand{\makeletterclosing}{%
    \par
    \ifx\letterclosingprefix\@empty
    \else
        \vspace{1em}
        \letterclosingprefix\par
    \fi

    \ifx\letterclosingtext\@empty
    \else
        \noindent\letterclosingtext\par
    \fi

    % 落款、签名与日期不跨页拆分
    \par\vspace{1.2em}
    \noindent\begin{minipage}{\linewidth}
        \raggedleft

        {\large\kaishu \sender}\par

        \ifx\signaturefile\@empty
        \else
            \vspace{0.4em}
            \includegraphics[
                width=3.2cm,
                height=1.8cm,
                keepaspectratio
            ]{\signaturefile}\par
        \fi

        \vspace{0.6em}
        {\kaishu \letterdate}\par
    \end{minipage}

    \vspace{1.5em}
    {\centering
        \scalebox{0.72}{\flourish}\par
    }
}

\endinput