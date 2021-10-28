\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tech-spec}[2021/10/18 A LaTeX class to technical specifications for MTHE 494]

\RequirePackage{pgfopts}

\def\ts@classoptions{%
  11pt,%
}

\pgfkeys{
  /tech-spec/.cd,
  % unknown keys are assumed to be options to be passed to the class
  .unknown/.code={\edef\ts@classoptions{\ts@classoptions,\pgfkeyscurrentname}},
}

\ProcessPgfOptions{/tech-spec}

% Get access to chapters in addition to sections.
\LoadClass[\ts@classoptions]{memoir}

% The header is empty and the folio (page number) is centered at the bottom of
% the page.
\pagestyle{plain}

\RequirePackage[margin=1in]{geometry}

% Standardize section styles.
\RequirePackage[tiny,compact,explicit]{titlesec}

% Reformat chapter text.
\titleformat{\chapter}{\centering}{}{0em}{#1}

% Change heading spacing.
\titlespacing{\chapter}{0pt}{-50pt}{-0.25\parskip}
\titlespacing{\section}{0pt}{\parskip}{-0.25\parskip}

% Change spacing between paragraphs.
\setlength{\parskip}{0.2in}

% Create environment to add double numeration to every paragraph within it.
\counterwithin*{paragraph}{section}
\newenvironment{parnumbers}{%
  \setlength{\parindent}{0cm}
  \par%
  \everypar{%
    \noindent%
    \hangindent=0.5in%
    \hangafter=1%
    \refstepcounter{paragraph}\label{par-\arabic{section}-\arabic{paragraph}}%
    \makebox[0.5in][l]{%
      % Text for the double numeration.
      \arabic{section}.\arabic{paragraph}%
    }%
  }%
}{%
  \par%
}
