\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mh-presentation}[2012/08/30 Presentation Class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{ifthen}
\RequirePackage{kvoptions}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class Options                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\SetupKeyvalOptions{prefix=mp@option@}
\DeclareStringOption{slides}
\DeclareStringOption{handouts}
\ProcessKeyvalOptions*

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compiling both Slides and Summary Sheets                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\mp@slides@name}{\expandafter\detokenize\expandafter{\mp@option@slides}}
\newcommand{\mp@handouts@name}{\expandafter\detokenize\expandafter{\mp@option@handouts}}

\ifthenelse{\equal{\jobname}{\mp@slides@name}}{
	\LoadClassWithOptions{mh-slides}
}{\ifthenelse{\equal{\jobname}{\mp@handouts@name}}{
	\LoadClassWithOptions{mh-summary-sheets}
}{
	\immediate%
	\write18{pdflatex -synctex=1 -interaction=nonstopmode -jobname=\mp@slides@name  \space \jobname.tex}
	
	\immediate%
	\write18{pdflatex -synctex=1 -interaction=nonstopmode -jobname=\mp@handouts@name\space \jobname.tex}
	
	\stop
}}
