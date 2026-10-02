{ ... }:
{
  flake.modules.nixos.music-reverse-proxy =
    { config, pkgs, ... }:
    {
      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      sops.secrets.metube = {
        owner = "caddy";
      };

      systemd.services.caddy = {
        preStart = ''
          if [ -f "${config.sops.secrets.metube.path}" ]; then
            HASH=$(${pkgs.caddy}/bin/caddy hash-password --plaintext "$(< ${config.sops.secrets.metube.path})")
            cat << EOF > /var/lib/caddy/metube-auth
basic_auth /metube* {
  tihdizer $HASH
}
EOF
          fi
        '';
        restartTriggers = [
          config.sops.secrets.metube.path
        ];
      };

      services.caddy = {
        enable = true;
        virtualHosts."music.tihdizer.online, direct-music.tihdizer.online" = {
          extraConfig = ''
            import /var/lib/caddy/metube-auth*

            reverse_proxy /metube* 127.0.0.1:8081

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
