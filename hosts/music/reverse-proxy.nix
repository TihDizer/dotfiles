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
        virtualHosts."music.tihdizer.online" = {
          extraConfig = ''
            reverse_proxy 127.0.0.1:8095 {
              transport http {
                versions 1.1
              }
              flush_interval -1
              header_up Host {host}
              header_up X-Real-IP {header.CF-Connecting-IP}
              header_up X-Forwarded-For {header.CF-Connecting-IP}
              header_up X-Forwarded-Proto https
            }
          '';
        };
      };
    };
}
