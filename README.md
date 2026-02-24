# James Middleton's CV

This repository contains my CV written in LaTeX, based on [this template on Overleaf](https://www.overleaf.com/latex/templates/rendercv-engineeringresumes-theme/shwqvsxdgkjy).

Feel free to use this as a template for you to create your own CV.

## Structure

```
main.tex                              <- preamble + \input{} orchestrator
sections/
  header.tex                          <- name, contact info, summary
  skills.tex                          <- skills section
  experience/
    2019-01-provq.tex                 <- oldest role first (alphabetical = chronological)
    2020-12-community-brands.tex
    2021-06-scrolller.tex
    2021-11-img-arena.tex
    2024-12-low6.tex                  <- newest role last
  education.tex
  projects.tex
```

## Getting Started

### Prerequisites

A [Nix](https://nixos.org/) flake provides all required tooling. With [direnv](https://direnv.net/) installed, the dev shell activates automatically when you `cd` into the project:

```sh
direnv allow   # first time only
```

Or enter the shell manually:

```sh
nix develop
```

This gives you:

- **TeX Live** (pdflatex, latexmk) with the required packages
- **tex-fmt** for formatting `.tex` files on save

### Building

```sh
latexmk -pdf main.tex
```

### Editing

Use VSCode with the recommended extensions (prompted on first open, or install via the Extensions panel):

- **[LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)** — live PDF preview and `tex-fmt` format on save
- **[direnv](https://marketplace.visualstudio.com/items?itemName=mkhl.direnv)** — automatically loads the Nix dev shell so VSCode tooling finds `latexmk`, `pdflatex`, and `tex-fmt`
