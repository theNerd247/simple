{ mkDerivation, base, bytestring, simple-core, stdenv }:
mkDerivation {
  pname = "simple-string";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base bytestring simple-core ];
  homepage = "https://github.com/githubuser/simple#readme";
  description = "Short description of your package";
  license = stdenv.lib.licenses.bsd3;
}
