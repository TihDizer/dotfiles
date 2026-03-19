{
  niri,
  walker,
  ...
}:

{
  imports = [
    # Core
    ./home.nix # home.username

    # Desktop
    ./niri/default.nix
    niri.homeModules.niri

    ./walker/default.nix
    walker.homeManagerModules.default

    ./utils/icons.nix

    ./files

    # Dev
    ./dev

    # Utils + Apps
    ./bash/default.nix
    ./chrome/default.nix
    ./fonts/default.nix
    ./utils/packages.nix
    ./utils/apps.nix
    ./utils/archives.nix
    ./utils/communication.nix
    ./utils/usb.nix
    ./yazi/default.nix

    # Shell
    ./shell/default.nix
  ];
}
