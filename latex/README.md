# Required packages
- esvect: it is included in texlive installations in texlive-fonts-extra. 

# Contents
## Packages 
### mycustom 
Includes my personal math commands:
- Common differential operators written in **bold**:     
    - `\rot` for the rotational operator. 
    - `\diver` for the divergence operator.
    - `\grad` for the gradient operator.

- Common transformation symbols: 
    - `\FT{·}` for the Fourier Transform Operator. 
    - `\LT{·}` for the Laplace Transform Operator. 

- Common matrix operations:
    - `\Tr{·}` for the trace operation. 
    - `\diag{·}` for denoting a diagonal matrix. 

- Common logical commands: 
    - `\tf` for therefore symbol (spacing adjusted). 
    - `\bc` for because symbol (spacing adjusted). 
    - `\eqdef` for denoting a definition symbol given by a an equal symbol adorned with a _def._ over it. 
    - `\qeq` for denoting a questioned equality given by an equal symbol adorned with a '?' over it. 

- Other common symbols in calculus: 
    - `\sign` to denote the sign operation. 
    - `\mean{·}` for surrounding an expresion with the angle mean symbol. 
    - `\ct{·}` for displaying a constant text symbol that changes according to the language (only spanish and english supported so far). 

- Symbols for quantum mechanics/reasoning: 
    - `\up` for an up arrow. 
    - `\down` for a down arrow. 

### mygeneral
Includes a list of frequently used packages. 

CODIFICATION
- inputenc \[utf8\]
- fontenc \[T1\]

MATHS and PHYSICS
- amsfonts
- amssymb
- mathtools
- physics
- mathrsfs
- amsthm
- empheq
- siunitx
- tensor
- cancel
- bm
- extarrows
- mhchem \[version=4\] (for compatibility)
- esvect \[b\] (selects a default type of arrow)

FIGURES AND TABLES
- graphicx
- float
- wrapfig
- caption
- subcaption
- array
- tabularx
- multirow
- longtable
- xcolor
- geometry \[a4paper, margin=2cm\]

DOCUMENT AND LAYOUT
- setspace
- ragged2e
- fancyhdr
- parskip
- multicol
- sidecap
- ifthen
- xparse
- hyperref
- appendix
- anyfontsize
- enumitem \[shortlabels, inline\] (allows using keys as a), i) as optional arguments for enumerate. Also allows inline lists using the starred version of enumerate )

### mytheorem_env
This package provides:
- Custom theorem/remark/definition/problem environments using thmtools + tcolorbox.
- Predefined colored boxed environments: theorem, proposition, corollary, lemma, claim, definition, example, remark, note, problem, solution, raw.
- Numbered and unnumbered (starred) variants for most environments.
- A reusable colored box environment cbox.
- A \Solution command that inserts a horizontal rule and prints the solution label.
- Spanish / English captions are added via \addto\captions... (depends on babel/polyglossia).

Dependencies (must be loaded / available)
- thmtools
- tcolorbox (the package uses \usepackage[most]{tcolorbox})
- xcolor with dvipsnames (for named colors)
- babel or polyglossia if you want language-specific captions (spanish/english)

#### Example of use
How to install / load
- Place LaTeX/packages/mytheorems_env.sty in your project or in a directory within TEXINPUTS.
- Load it from your document preamble. Examples:
  - If you keep the file as-is (it declares `\ProvidesPackage{packages/mytheorems_env}`) then call the package through:
    `\usepackage{packages/mytheorems_env}` in the main file.
  - The package can also be renamed to mytheorems_env.sty replacing `\ProvidesPackage{packages/mytheorems_env}` to `\ProvidesPackage{/mytheorems_env}` in the file \[mytheorems_env.sty\] and then use: `\usepackage{mytheorems_env}` in the main file.

Minimal usage example using the first suggested option: 

```latex
\documentclass{article}
\usepackage[spanish]{babel} % or [english]
\usepackage{packages/mytheorems_env} % path/name as explained above
\begin{document}

\begin{theorem}[Pythagoras]\label{thm:py}
Let a,b,c satisfy ...
\end{theorem}

\begin{theorem*}
Unnumbered theorem text.
\end{theorem*}

\begin{definition}
A definition example.
\end{definition}

% The manual solution command
\Solution
Here is a resolution written using the package macro.

% Using the generic colored box
\begin{cbox}[title=Tip]
A short tip inside a colored box.
\end{cbox}

\end{document}
```

### mylayout

This package ease the management of the layout of the document such as: headings, titles, footers, institution features and logos. It achieve so by collecting metadata and predefining two customizable themes: assignment and project. 
The metadata needed is collected through 3 commands: 
- `\institution{·}`: 
    - Name of the institution in the key: `name`. 
    - If there is a logo associated, it can be introduced in the key: `logo`. 
- `\pagelayout{·}`: 
    - The right headder is allowed to display whatever the user wants, e.g. its name. It can be accessed through the key: `rightheadder`. 
    - The left headder  is used for displaying information about the institution. If the key `showlogo` is set to `true` then the logo will be shown on this side of the header. Otherwise the name of the institution will be used instead. The **default behaviour** is to hide the logo and display the name. 
    - Styles for figures and tables can be set through the keys `figurestyle` and `tablestyle` respectively. The package includes the styles: `figure_1`, `subfigure`, `subfigure2` and `table_1`. However, more styles can be added as long as they are defined before the calling this package. Bear in mind that those defintions are supported by the packages `caption` and `subcaption`.
- `\titlesetup{·}`: 
    - The first key to be defined is the theme: **assignment** or **project**. The **default theme** is _assignment_. 
    - The title is stored in the key `title`. This key is common to both themes.
    - For the project theme it can also be set a subtitle via the `subtitle` key. In case it is defined with the assignment theme, it will be ignored. These will be the standard behaviour for keys used in themes different to the ones for which they were made. 
    - The author is stored in the key `author`, common to both themes. 
    - For the assignment theme, the subject can be stored in the key `subject`. 
    - For the project theme, the type of project can be stored in the key `projectname` and additional features in the key `projectsubname`. This two can be combined according to the display desired by the user. For instance, let's assume the user is dealing with a Master Thesis in Science, then as the subname is placed in a diferent line the user may use either _Master in Science_ for the `projectname` and _Thesis_ for the `projectsubname` or just use _Master's Thesis in Science_ in the `projectname` key. 
    - For the project theme there can also defined the fields: _supervisor_ and _academic year_ with keys with the same name: `supervisor`, `academicyear`. **NOTE**: you can also use _supervisor**s**_ when there are multiple ones. 
    - For the assignment theme the date is stored in the key `date`. 
 
**New implementation**: recently it has been added support for displaying the name of the fields either in Spanish or English (default if babel package is not included). 
#### Other features
This package uses the `hyperref` package and has the following defaults for its setup: 
```latex 
 \hypersetup{
      colorlinks=true,
      linkcolor=blue, citecolor=blue, filecolor=magenta, urlcolor=blue,
      pdfpagemode=FullScreen,
      linktocpage=false, 
      linkcolor=blue, 
      citecolor=blue, 
      filecolor=magenta, 
      urlcolor=blue,
  }
\urlstyle{same}
```
It also includes a command (`\resetnumpagetitle`) for displaying an empty pagestyle in the current page and reset the numeration in the following one. It is meant to be used for indices and titles in separated pages but it is easily usable in other contexts (e.g. bibliographies, appendices, ...). The page style to be used after using this command can be whichever the user wants, but if the one used by the theme is meant to be used, its name is `academic`. 
### Other not original packages
There can be found other useful packages such as: 
- `dangbox.sty`: credits to: [MrCherub](https://github.com/MrCherub/vimtex-dangbox)
- `epibox.sty`: credit to: [MrCherub](https://github.com/MrCherub/epibox)

## Templates 
Here there can be found templates made for using the packages mentioned above. By now there is only one: `fancy_template.tex`. The defaults include the packages: `babel`, `mygeneral` and `mylayout`. 
## LaTeX conversors
- LaTeX to SVG: the bash script `tex2svg.sh` is a tool for converting your LaTeX code into a SVG image. The tool proves to be useful when dealing with presentation programmes without LaTeX integration such as PowerPoint. Although there are more polished alternatives (see for instance [The IguanaTeX project](https://www.jonathanleroux.org/software/iguanatex/)), the simplicity of this tool allows full control over the content and ease on finding errors. The syntax for using it is: `text2svg.sh file.tex` and the output will be `file.svg`. Here is a minimal example:

```latex
\documentclass[preview]{standalone}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{colorx}

\begin{document}
\begin{equation*}
\color{white} x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
\end{equation*}
\end{document}
```
Calling this file `example.tex` then the conversion is achieved by: 

```bash
text2svg.sh example.tex
```

Being the results: 

![Quadratic Formula](conversors/example.svg)
