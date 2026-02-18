{
  description = "James Middleton's CV";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
  let
    forAllSystems = f: nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "x86_64-linux"
      "aarch64-linux"
    ] (system: f nixpkgs.legacyPackages.${system});

    texlive = pkgs: pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        latexmk
        charter
        enumitem
        titlesec
        needspace
        paracol
        changepage
        fancyhdr
        bookmark
        xcolor
        iftex
        ;
    };
  in
  {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = [
          (texlive pkgs)
          pkgs.tex-fmt
        ];
      };
    });
  };
}
