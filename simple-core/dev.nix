let
  pkgs = import <nixpkgs> {};
in

{simple-core = pkgs.haskellPackages.callPackage ./default.nix {};
}
