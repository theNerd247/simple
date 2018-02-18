{ mkDerivation, aeson, base, simple, stdenv }:
mkDerivation {
  pname = "simple-aeson";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ aeson base simple ];
  homepage = "https://github.com/githubuser/simple#readme";
  description = "Short description of your package";
  license = stdenv.lib.licenses.bsd3;
}
