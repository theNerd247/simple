let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = old: new: {
          simple-string = pkgs.haskellPackages.callPackage ./default.nix {
            simple-core = pkgs.haskellPackages.callPackage ../simple-core/default.nix {};
          };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in

{simple-string = pkgs.haskellPackages.simple-string;
}
