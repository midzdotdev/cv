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
        shellHook = ''
          if [ -d .git ]; then
            mkdir -p .git/hooks
            cat > .git/hooks/pre-commit << 'HOOK'
          #!/usr/bin/env bash
          staged_tex=$(git diff --cached --name-only --diff-filter=ACM | grep '\.tex$')
          if [ -z "$staged_tex" ]; then
            exit 0
          fi
          for file in $staged_tex; do
            tex-fmt "$file"
            git add "$file"
          done
          HOOK
            chmod +x .git/hooks/pre-commit
          fi
        '';
      };
    });
  };
}
