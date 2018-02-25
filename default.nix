{buildEnv, simple-core, simple-aeson, simple-snap, simple-string}:

buildEnv {
  name = "simple-1.0.0";
  paths = [simple-core simple-aeson simple-snap simple-string];
}
