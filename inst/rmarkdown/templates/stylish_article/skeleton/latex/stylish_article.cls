% ---------------------------------------------------------------------
% SelfArx : Conference proceedings and article templates for
% personal open-archiving activities
% September 2012
% Modifié pour les besoins de l'UMR EcoFoG (Eric Marcon)
% ---------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ArtEcoFoG}[06/11/2017, v. 2.1]
\RequirePackage{ifthen}
\RequirePackage{calc}
\AtEndOfClass{\RequirePackage{microtype}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*
\LoadClass{article}

\RequirePackage{times}      % Loads the Times-Roman Fonts
\RequirePackage{mathptmx}   % Loads the Times-Roman Math Fonts
\RequirePackage{ifpdf}      % Needed to pick between latex and pdflatex

% ---------------------------------------------------------------------
\RequirePackage{natbib}         % Bibliographie avancée (parenthèses, citep...). Avant babel.
\RequirePackage[utf8]{inputenc} % Pour les accents
\RequirePackage[T1]{fontenc}    % Pour les accents
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage{graphicx,xcolor}
\RequirePackage{booktabs}
% ---------------------------------------------------------------------


% ---------------------------------------------------------------------
% margins
\RequirePackage[left=2cm,%
                right=2cm,%
                top=2.25cm,%
                bottom=2.25cm,%
                headheight=11pt,%
                a4paper] %
                {geometry}%
\RequirePackage[labelfont={bf,sf},%
                labelsep=period,%
                justification=raggedright] %
                {caption}
% ---------------------------------------------------------------------
\RequirePackage{fancyhdr}  % Needed to define custom headers/footers
\RequirePackage{lastpage}  % Number of pages in the document
\pagestyle{fancy}          % Enables the custom headers/footers
% Headers
\lhead{}%
\chead{}%
\rhead{\small\sffamily\bfseries\@PaperTitle\  --- \thepage/\pageref{LastPage}}
% Footers
\lfoot{}%
\cfoot{}%
\rfoot{}%
\renewcommand{\headrulewidth}{0pt}% % No header rule
\renewcommand{\footrulewidth}{0pt}% % No footer rule
% ---------------------------------------------------------------------
% section/subsection/paragraph set-up
\RequirePackage[explicit]{titlesec}
\titleformat{\section}
  {\color{color1}\large\sffamily\bfseries}
  {}
  {0em}
  {\colorbox{color2!10}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\centering\arabic{section}. #1}}}
  []
\titleformat{name=\section,numberless}
  {\color{color1}\large\sffamily\bfseries}
  {}
  {0em}
  {\colorbox{color2!10}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\centering#1}}}
  []
\titleformat{\subsection}
  {\color{color1}\sffamily\bfseries}
  {\thesubsection}
  {0.5em}
  {#1}
  []
\titleformat{\subsubsection}
  {\sffamily\small\bfseries}
  {\thesubsubsection}
  {0.5em}
  {#1}
  []
\titleformat{\paragraph}[runin]
  {\sffamily\small\bfseries}
  {}
  {0em}
  {#1}
\titlespacing*{\section}{0pc}{3ex \@plus4pt \@minus3pt}{5pt}
\titlespacing*{\subsection}{0pc}{2.5ex \@plus3pt \@minus2pt}{0pt}
\titlespacing*{\subsubsection}{0pc}{2ex \@plus2.5pt \@minus1.5pt}{0pt}
\titlespacing*{\paragraph}{0pc}{1.5ex \@plus2pt \@minus1pt}{10pt}
% ---------------------------------------------------------------------
% tableofcontents set-up
\usepackage{titletoc}
\contentsmargin{0cm}
\titlecontents{section}[\tocsep]
  {\addvspace{4pt}\small\bfseries\sffamily}
  {\contentslabel[\thecontentslabel]{\tocsep}}
  {}
  {\hfill\thecontentspage}
  []
\titlecontents{subsection}[\tocsep]
  {\addvspace{2pt}\small\sffamily}
  {\contentslabel[\thecontentslabel]{\tocsep}}
  {}
  {\ \titlerule*[.5pc]{.}\ \thecontentspage}
  []
\titlecontents*{subsubsection}[\tocsep]
  {\footnotesize\sffamily}
  {}
  {}
  {}
  [\ \textbullet\ ]
% ---------------------------------------------------------------------
% Get the multiple author set
\newcount\@authcnt
\newcount\@tmpcnt\@tmpcnt\z@

\def\@affiliation{%
  \ifnum\@tmpcnt<\@authcnt
   \global\advance\@tmpcnt1
    \raggedright \csname @auth\romannumeral\the\@tmpcnt\endcsname\hfill\\%
   \let\next\@affiliation \vskip1pt
  \else
   \let\next\relax
  \fi
\next}


\newcommand{\affiliation}[1]{%
    \global\advance\@authcnt1
    \expandafter\gdef\csname @auth\romannumeral\the\@authcnt\endcsname
    {#1}}
% ---------------------------------------------------------------------
% Remove brackets from numbering in List of References
\renewcommand{\@biblabel}[1]{\bfseries\color{color1}\textsuperscript{[#1]}}
%\setlength{\bibitemsep}{0cm}
% ---------------------------------------------------------------------
\newcommand{\PaperTitle}[1]{\def\@PaperTitle{#1}}
\newcommand{\Archive}[1]{\def\@Archive{#1}}
\newcommand{\Authors}[1]{\def\@Authors{#1}}
\newcommand{\JournalInfo}[1]{\def\@JournalInfo{#1}}
\newcommand{\Abstract}[1]{\def\@Abstract{#1}}
\newcommand{\Keywords}[1]{\def\@Keywords{#1}}
% ---------------------------------------------------------------------
\renewcommand{\@maketitle}{%
\twocolumn[{%
\thispagestyle{empty}%
\vskip-36pt%
{\raggedleft\small\sffamily\bfseries\@JournalInfo\\\@Archive\par}%
\vskip20pt%
{\raggedright\color{color1}\sffamily\bfseries\fontsize{20}{25}\selectfont\@PaperTitle\par}%
\vskip10pt
{\raggedright\color{color1}\sffamily\fontsize{12}{16}\selectfont\@Authors\par}
\vskip18pt%
\fcolorbox{color1}{white}{%
\parbox{\textwidth-2\fboxsep-2\fboxrule}{\centering%
\colorbox{color2!10}{%
\parbox{\textwidth-3.5\fboxsep-3.5\fboxrule}{%
\ifx\@Keywords\@empty
\sffamily\small\textbf{\abstractname}\\\@Abstract
\else
\sffamily\small\textbf{\abstractname}\\\@Abstract\\[5pt]%
\textbf{\keywordname}\\\@Keywords%
\fi
}%
}%
\vskip5pt%
\begingroup%
\raggedright\sffamily\small%
\footnotesize\@affiliation\par%
\endgroup%%
}%
}%
\vskip25pt%
}]%
}%
% ---------------------------------------------------------------------

% -------------- Personnalisation EcofoG
\setlength{\columnsep}{0.55cm}      % Distance between the two columns of text
\setlength{\fboxrule}{0.75pt}       % Width of the border around the abstract

\definecolor{color1}{RGB}{0,0,90}   % Color of the article title and sections
\definecolor{color2}{RGB}{0,20,20}  % Color of the boxes behind the abstract and headings

\newlength{\tocsep}                 % Format de la table des matières
\setlength\tocsep{1.5pc}            % Sets the indentation of the sections in the table of contents

\RequirePackage{tabularx}           % Retour à la ligne des tableaux
  \renewcommand{\arraystretch}{1.8}
\RequirePackage{multirow}           % Fusion des lignes dans les tableaux
\RequirePackage{breqn}              % Retour à la ligne des équations
\RequirePackage{url}                % Retour à la ligne des url
\RequirePackage{hyperref}           % Liens hypertextes, signets PDF
  \hypersetup{urlcolor=blue,linkcolor=black,citecolor=black,colorlinks=true}

  \graphicspath{{graphics/}}        % Dossier de stockage des figures
\RequirePackage{epstopdf}           % Figures eps
\RequirePackage{enumitem}           % Espacement dans les listes
  \setlist[itemize]{noitemsep,nolistsep}
  \setlist[enumerate]{noitemsep,nolistsep}

% code command
\newcommand{\code}[1]{\begingroup \ttfamily #1\endgroup}
% Variance
\def\Var{\mathop{\mathrm{Var}}}

\RequirePackage[french, english]{babel}
  \frenchbsetup{StandardLists=true} % à inclure si on utilise \usepackage[french]{babel} ou les puces seront des tirets cadratins
