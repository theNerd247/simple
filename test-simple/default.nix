{ mkDerivation, aeson, base, exceptions, lens, simple, simple-aeson
, simple-snap, simple-string, snap, stdenv, text, transformers
}:
mkDerivation {
  pname = "test-simple";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base exceptions lens simple simple-aeson simple-snap
    simple-string snap text transformers
  ];
  license = stdenv.lib.licenses.unfree;
}
