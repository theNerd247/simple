{ mkDerivation, aeson, base, exceptions, simple-core, stdenv }:
mkDerivation {
  pname = "simple-aeson";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ aeson base exceptions simple-core ];
  homepage = "https://github.com/githubuser/simple#readme";
  description = "Short description of your package";
  license = stdenv.lib.licenses.bsd3;
}
