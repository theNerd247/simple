let
  pkgs = import <nixpkgs> {};
in

{ 
  simple = pkgs.haskellPackages.callPackage ./simple/default.nix {};
  simple-aeson = pkgs.haskellPackages.callPackage ./simple-aeson/default.nix {};
  simple-snap = pkgs.haskellPackages.callPackage ./simple-snap/default.nix {};
  simple-string = pkgs.haskellPackages.callPackage ./simple-aeson/default.nix {};
}
