\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mh-slides}[2012/08/24 Slides Class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClassWithOptions{beamer}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{environ}
\RequirePackage{ifthen}
\RequirePackage{etoolbox}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title Information at Beginning of Document                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AfterEndPreamble{%
	\begin{frame}%
		\maketitle%
	\end{frame}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Semisection                                      (see mh-summary-sheets.cls) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\semisection}[1]{\section[]{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Summary Environment                              (see mh-summary-sheets.cls) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The summary environment  has a title only on the summary sheets, but
% is not indexed, numbered, or represented on the slides.

\NewEnviron{summary}[1][]{}

\newcommand{\showThisSlide}[1][1]{}
\newcommand{\showPreviousSlide}[1][1]{}
\newcommand{\showPreviousPreviousSlide}[1][1]{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slide Environment                                (see mh-summary-sheets.cls) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO: Move this to a more appropriate place?
\newcount\level
\makeatletter
\let\Part@=\part\def\part{\global\level=0\Part@}
\let\Chapter@=\chapter\def\chapter{\global\level=1\Chapter@}
\let\Section@=\section\def\section{\global\level=2\Section@}
\let\Subsection@=\subsection\def\subsection{\global\level=3\Subsection@}
\let\Subsubsection@=\subsubsection\def\subsubsection{\global\level=4\Subsubsection@}
\makeatother

\newcommand{\insubsection}[1]{\ifthenelse{\level = 3}{#1}{}}

\newcounter{SlideNumber}
\xdef\SlideLabel{NO SLIDES YET}

\newenvironment{slide}[1][automaticLabelName]{
	\ifthenelse{\equal{#1}{automaticLabelName}}{
		\global\edef\SlideLabel{slide\arabic{SlideNumber}}
	}{
		\global\edef\SlideLabel{#1}
	}
	\stepcounter{SlideNumber}
	
	\begin{frame}[label=\SlideLabel]
		\frametitle{\insertsection}
		\insubsection{\framesubtitle{\insertsubsection}}
		}{ % BODY
	\end{frame}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slide Repetition Commands                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\repeatslide}[2][1]{\againframe<#1>{#2}}
\newcommand{\repeatoverlay}[1]{\againframe<#1>{\SlideLabel}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Horizontal Centering on Slides                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\centering
