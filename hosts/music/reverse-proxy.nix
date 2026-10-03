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

        virtualHosts."navidrome.tihdizer.online" = {
          extraConfig = ''
            handle_path /covers/* {
              root * /var/lib/music-dl-bot/covers
              file_server
            }

            handle_path /audio/* {
              root * /var/media/music
              file_server
            }

            reverse_proxy 127.0.0.1:4533
          '';
        };

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
