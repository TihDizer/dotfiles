{ inputs, ... }:
{
  flake.modules.nixos.music =
    { config, ... }:
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
    sops.secrets."music-bot-token" = {
      sopsFile = ../../secrets/music-secrets.yaml;
      owner = "tihdizer";
    };

    networking.hostName = "music";

    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
}
