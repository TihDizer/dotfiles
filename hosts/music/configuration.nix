{ inputs, ... }:
{
  flake.modules.nixos.music =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        music-disko
        music-hardware
        music-locales
        music-system
        music-users
        music-reverse-proxy
        music-litestream
        music-r2-mount

        sops
        navidrome
        ssh
        yazi
      ];

      sops.age.keyFile = null;
      sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      environment.systemPackages = with pkgs; [
        bottom
      ];

      networking.hostName = "music";

      zramSwap = {
        enable = true;
        memoryPercent = 50;
      };

      system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    };
}
