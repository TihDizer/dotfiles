{ inputs, ... }:
{
  flake.modules.nixos.music = {
    imports = with inputs.self.modules.nixos; [
      #= Host
      music-disko
      music-hardware
      music-locales
      music-system
      music-users

      #= Secrets & Networking
      sops
      dae
      ssh
      music-assistant
      music-reverse-proxy
    ];

    sops.age.keyFile = null;
    sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    networking.hostName = "music";

    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}
