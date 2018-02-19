let
  simple = pkgs.haskellPackages.callPackage ../simple/default.nix {};

  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = old: new: {
          simple-string = pkgs.haskellPackages.callPackage ./default.nix {
            simple = simple;
          };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in

{simple-string = pkgs.haskellPackages.simple-string;
}
