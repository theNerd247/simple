{pkgs ? import <nixpkgs> {} }:

{ simple = import ./default.nix {
    inherit (pkgs) buildEnv;
    inherit (import ./simple-core/dev.nix) simple-core;
    inherit (import ./simple-aeson/dev.nix) simple-aeson;
    inherit (import ./simple-snap/dev.nix) simple-snap;
    inherit (import ./simple-string/dev.nix) simple-string;
  };
}
