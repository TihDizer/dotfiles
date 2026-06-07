{ inputs, ... }:
{
  flake.modules.nixos.main = {
    imports = with inputs.self.modules.nixos; [
      host-main-hardware
      host-main-system
      host-main-locales
      host-main-users

      system-default

      shell
      appimage
      winapps

      docker

      programs-desktop-niri
      sunshine

      steam
      # prism-launcher

      throne
      firewall
      networkmanager

      qemu
      nvf

      home-manager
      niri-scratchpad
    ];

    networking.hostName = "main";

    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    home-manager.users.tihdizer = inputs.self.modules.homeManager.tihdizer;
  };
}
