{
  niri,
  ...
}:

{
  imports = [
    # Core
    ./home.nix # home.username

    # Desktop
    ./niri/default.nix
    niri.homeModules.niri

    # Editor
    ./dev/zed-editor.nix
    ./helix/default.nix

    # Dev
    ./dev/go.nix
    ./dev/nix.nix
    ./dev/python.nix
    ./dev/rust.nix
    ./dev/dockerfile.nix
    ./dev/git.nix
    ./dev/antigravity.nix

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
    ./walker/default.nix

    # Shell
    ./shell/default.nix
  ];
}
