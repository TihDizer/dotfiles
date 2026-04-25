{ ... }:
{
  flake.modules.nixos.programs-desktop-niri-env =
    { ... }:
    {
      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];
    };
}
