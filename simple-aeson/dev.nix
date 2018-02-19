let
  simple = pkgs.haskellPackages.callPackage ../simple/default.nix {};

  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = old: new: {
          simple-aeson = pkgs.haskellPackages.callPackage ./default.nix {
            simple = simple;
          };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in

{simple-aeson = pkgs.haskellPackages.simple-aeson;
}
