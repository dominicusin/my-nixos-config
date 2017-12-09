{ pkgs ? import <nixpkgs> {} }:
 let
   myEmacs = (pkgs.emacs.override { withGTK3 = true; withGTK2 = false; });
   emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
 in
   emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
     magit          # ; Integrate git <C-x g>
     zerodark-theme # ; Nicolas' theme
   ]) ++ (with epkgs.melpaPackages; [
     undo-tree      # ; <C-x u> to show the undo tree
   ]) ++ (with epkgs.elpaPackages; [
     auctex         # ; LaTeX mode
     beacon         # ; highlight my cursor when scrolling
     nameless       # ; hide current package name everywhere in elisp code
   ]) ++ [
     pkgs.notmuch   # From main packages set
   ])
