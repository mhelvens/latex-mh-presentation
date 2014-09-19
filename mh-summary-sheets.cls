\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mh-summary-sheets}[2012/10/04 Summary-sheets Class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class Options                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{kvoptions}
\SetupKeyvalOptions{prefix=option@}
\DeclareStringOption{slides}
\ProcessKeyvalOptions*

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClassWithOptions{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{beamerarticle,pgf}
\RequirePackage{environ}
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{sectsty}
\RequirePackage{url}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title Information at Beginning of Document                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AfterEndPreamble{\maketitle}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Semisection                                              (see mh-slides.cls) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\semisection}[1]{\section*{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Summary Environment                                      (see mh-slides.cls) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\normalparindent}
\setlength{\normalparindent}{\parindent}

\def\IsNumber#1{%
  TT\fi
  \ifcat_\ifnum0<0#1 _\else A\fi
}

\newenvironment{summary}[1][1]{
	\noindent\begin{minipage}[t]{0.39\linewidth}
		\setlength\fboxsep{0pt}
		\vspace{0pt}\fbox{\includeslide[width=\linewidth]{%
			\if\IsNumber{#1}%
				\SlideLabel<#1>%
			\else%
				#1%
			\fi%
		}}
	\end{minipage}
	\hfill
	\begin{minipage}[t]{0.58\linewidth}\vspace{.5ex}
		\setlength{\parindent}{\normalparindent}
		\noindent\ignorespaces
		}{ % BODY
	\end{minipage}\vspace{2ex}
}

\newcommand{\@showSlide}[2]{
	\noindent\begin{minipage}[t]{0.315\linewidth}
		\setlength\fboxsep{0pt}
		\vspace{0pt}\fbox{\includeslide[width=\linewidth]{%
			\if\IsNumber{#1}%
				#2<#1>%
			\else%
				#1%
			\fi%
		}}
	\end{minipage}
}

\newcommand{\showPreviousPreviousSlide}[1][1]{
	\@showSlide{#1}{\PreviousPreviousSlideLabel}
}

\newcommand{\showPreviousSlide}[1][1]{
	\@showSlide{#1}{\PreviousSlideLabel}
}

\newcommand{\showThisSlide}[1][1]{
	\@showSlide{#1}{\SlideLabel}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slide Environment                                        (see mh-slides.cls) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{SlideNumber}
\xdef\SlideLabel{NO SLIDES YET}
\xdef\PreviousSlideLabel{NO TWO SLIDES YET}
\xdef\PreviousPreviousSlideLabel{NO THREE SLIDES YET}

\NewEnviron{slide}[1][automaticLabelName]{
	\xdef\PreviousPreviousSlideLabel{\PreviousSlideLabel}
	\xdef\PreviousSlideLabel{\SlideLabel}
	\ifthenelse{\equal{#1}{automaticLabelName}}{
		\xdef\SlideLabel{slide\arabic{SlideNumber}}
	}{
		\xdef\SlideLabel{#1}
	}
	\stepcounter{SlideNumber}
}

\newcommand{\repeatslide}[2][1]{}
\newcommand{\repeatoverlay}[1]{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Point to Slides PDF File                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setjobnamebeamerversion{\option@slides}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reduce Page Margins                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[margin=0.5in]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Underline Section Headers                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\sectionfont{\sectionrule{0pt}{0pt}{-1ex}{1pt}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove Page Numbers                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makeatletter
  \let\ps@plain\ps@empty
\makeatother

\pagestyle{empty}
