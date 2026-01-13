{
  config,
  pkgs,
  niri,
  ...
}:
{
  imports = [
    ./packages.nix
    ./settings.nix
  ];
}
