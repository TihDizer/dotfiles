{ ... }:
{
  flake.modules.nixos.music-reverse-proxy =
    { ... }:
    {
      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      services.caddy = {
        enable = true;
        virtualHosts."music.tihdizer.online, direct-music.tihdizer.online" = {
          extraConfig = ''
            @cf header CF-Connecting-IP *
            reverse_proxy @cf 127.0.0.1:8095 {
              transport http {
                versions 1.1
              }
              flush_interval -1
              header_up Host {host}
              header_up X-Real-IP {header.CF-Connecting-IP}
              header_up X-Forwarded-For {header.CF-Connecting-IP}
              header_up X-Forwarded-Proto https
            }

            reverse_proxy 127.0.0.1:8095 {
              transport http {
                versions 1.1
              }
              flush_interval -1
              header_up Host {host}
              header_up X-Real-IP {remote_host}
            }
          '';
        };
      };
    };
}
