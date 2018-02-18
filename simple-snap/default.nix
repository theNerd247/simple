{ mkDerivation, base, bytestring, case-insensitive, exceptions
, lifted-base, mtl, simple, snap, stdenv, transformers
}:
mkDerivation {
  pname = "simple-snap";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    base bytestring case-insensitive exceptions lifted-base mtl simple
    snap transformers
  ];
  homepage = "https://github.com/githubuser/simple#readme";
  description = "Short description of your package";
  license = stdenv.lib.licenses.bsd3;
}
