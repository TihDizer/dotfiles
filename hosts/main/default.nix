{
  specialArgs,
  ...
}:

{
  nixpkgs.overlays = [ specialArgs.rust-overlay.overlays.default ];
  imports = [
    # Hardware
    ./hardware.nix

    # Configuration
    ./configuration.nix

    # Locales
    ./locales.nix

    # Users
    ./users.nix

    # Base
    ../../modules/core/default.nix

    # Shell
    ../../modules/shell/default.nix

    # Desktop + niri
    ../../modules/desktop/appimage.nix
    ../../modules/desktop/winapps.nix
    ../../modules/desktop/niri/default.nix
    # ../../modules/desktop/sunshine.nix

    # Games
    # todo ../modules/games/prism-launcher/default.nix
    ../../modules/games/steam.nix

    # Network/VPN/Proxy
    ../../modules/networking/zapret.nix
    ../../modules/networking/throne.nix
    ../../modules/networking/firewall.nix
    ../../modules/networking/networkmanager.nix

    # Virtualization
    ../../modules/virtualization/docker.nix
    ../../modules/virtualization/qemu.nix
  ];

  networking.hostName = "main";
}
