{ mkDerivation, base, bytestring, exceptions, mtl, stdenv
, transformers
}:
mkDerivation {
  pname = "simple";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    base bytestring exceptions mtl transformers
  ];
  homepage = "https://github.com/githubuser/simple#readme";
  description = "Short description of your package";
  license = stdenv.lib.licenses.bsd3;
}
