{ inputs, ... }:
{
  flake.modules.nixos.main = {
    imports = with inputs.self.modules.nixos; [
      host-main-hardware
      host-main-system
      host-main-locales
      host-main-users

      system-default

      programs-shell

      programs-desktop-appimage
      programs-desktop-winapps
      programs-desktop-niri
      # services-sunshine

      programs-games-steam

      services-networking-zapret
      services-networking-throne
      services-networking-firewall
      services-networking-networkmanager

      services-virtualization-docker
      services-virtualization-qemu

      home-manager
    ];

    networking.hostName = "main";

    home-manager.users.tihdizer = inputs.self.modules.homeManager.tihdizer;
  };
}
