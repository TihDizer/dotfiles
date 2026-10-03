{ ... }:
{
  flake-file.inputs = {
  };

  flake.modules.nixos.music-assistant =
    { ... }:
    {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      networking.firewall.allowedTCPPorts = [
        # 8095 # UI
        # 8097
      ];

      virtualisation.oci-containers.backend = "podman";
      virtualisation.oci-containers.containers = {
        music-assistant = {
          image = "ghcr.io/music-assistant/server:latest";
          autoStart = true;

          extraOptions = [
            "--net=host"
          ];

          volumes = [
            "/var/lib/music-assistant:/data"
            "/var/media/music:/music:ro"
          ];

          environment = {
            TZ = "Europe/Moscow";
          };
        };

        yt-po-token-generator = {
          image = "docker.io/brainicism/bgutil-ytdlp-pot-provider:latest";
          autoStart = true;
          extraOptions = [
            "--net=host"
          ];
          environment = {
            PORT = "4416";
            TOKEN_TTL = "6";
          };
        };
      };

      systemd.tmpfiles.rules = [
        "d /var/lib/music-assistant 0755 root root -"
        "d /var/media/music 0755 root root -"
      ];
    };
}
