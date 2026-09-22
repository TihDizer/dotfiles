{ inputs, ... }:
{
  flake.modules.nixos.main = {
    imports = with inputs.self.modules.nixos; [
      #= Host
      host-main-hardware
      host-main-disko
      host-main-preservation
      host-main-system
      host-main-locales
      host-main-users
      system-default
      home-manager

      #= Shell
      shell
      sops

      #= Dev
      jcode
      herdr

      #= Networking
      networkmanager
      firewall
      dae
      throne
      ssh

      #= Virtualization
      qemu
      podman
      winapps
      # docker

      #= TODO: Desktop
      programs-desktop-niri
      sunshine

      #= Gaming
      steam
      # prism-launcher
    ];

    networking.hostName = "main";

    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    home-manager.users.tihdizer = inputs.self.modules.homeManager.tihdizer;
  };
}
