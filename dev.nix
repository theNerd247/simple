let
  pkgs = import <nixpkgs> {};
  simple-aeson = import ./simple-aeson/dev.nix;
  simple-snap = import ./simple-snap/dev.nix;
  simple-string = import ./simple-string/dev.nix;
in

{ 
  simple = pkgs.haskellPackages.callPackage ./simple/default.nix {};
  simple-aeson = simple-aeson;
  simple-snap = simple-snap;
  simple-string = simple-string;
}
