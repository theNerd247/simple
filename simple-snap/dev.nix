let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = new: old: rec {
          simple-snap =
            let 
              snap = old.snap.override {
                heist = pkgs.haskell.lib.dontCheck old.heist;
              };
            in
             pkgs.haskellPackages.callPackage ./default.nix {
               simple-core = pkgs.haskellPackages.callPackage ../simple-core/default.nix {};
               snap = snap;
             };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in

{simple-snap = pkgs.haskellPackages.simple-snap;
}
