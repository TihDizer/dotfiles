{ inputs, ... }:
{
  flake.modules.nixos.main = {
    imports = with inputs.self.modules.nixos; [
      #= Host
      host-main-hardware
      host-main-system
      host-main-locales
      host-main-users
      system-default
      home-manager

      #= Shell
      shell
      sops

      #= Networking
      networkmanager
      firewall
      dae
      throne
      ssh

      #= Virtualization
      qemu
      podman
      # docker

      #= TODO: Desktop
      programs-desktop-niri
      niri-scratchpad
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
