{ ... }:
let
  daeConfigTemplate = subscriptionUrl: ''
    global {
      tproxy_port: 12345
      tproxy_port_protect: true
      log_level: info
      wan_interface: auto
      auto_config_kernel_parameter: true
      dial_mode: domain
      tls_implementation: tls
      tcp_check_url: 'http://cp.cloudflare.com,1.1.1.1,2606:4700:4700::1111'
      tcp_check_http_method: HEAD
      udp_check_dns: 'dns.google:53,8.8.8.8,2001:4860:4860::8888'
      check_interval: 30s
      check_tolerance: 50ms
    }

    subscription {
      proxy: '${subscriptionUrl}'
    }

    dns {
      upstream {
        alidns: 'udp://dns.alidns.com:53'
        googledns: 'tcp+udp://dns.google:53'
      }
      routing {
        request {
          qname(geosite:cn) -> alidns
          fallback: googledns
        }
      }
    }

    group {
      proxy {
        filter: subtag(proxy)
        policy: min_moving_avg
      }
    }

    routing {
      pname(NetworkManager) -> direct
      dip(224.0.0.0/3, 'ff00::/8') -> direct
      dip(geoip:private) -> direct

      l4proto(udp) && dport(443) -> block

      domain(suffix: discord.com, suffix: discordapp.com, suffix: discordapp.net, suffix: discord.gg) -> proxy
      domain(suffix: discord.media, suffix: discordcdn.com, suffix: discordstatus.com) -> proxy

      domain(nixos.org, nix.dev, search.nixos.org) -> direct
      domain(kick.com, dashboard.kick.com, givefreely.com, trustedhousesitters.com, perplexity.ai, linkedin.com, britishcouncil.org, whatismyipaddress.com, b4mcx2ml.net, notebooklm.google, chatgpt.com, zoom.us, app.zoom.us, google.zoom.us, dub.co, partners.dub.co, annas-archive.li) -> proxy
      domain(suffix: amazonaws.com, suffix: google.com, suffix: b-cdn.net) -> proxy

      pname(Telegram) -> proxy
      pname(.Telegram-wrapped) -> proxy
      domain(suffix: t.me, suffix: telegram.org, suffix: telegram.dog) -> proxy

      dip(geoip:cn) -> direct
      domain(geosite:cn) -> direct

      fallback: proxy
    }
  '';
in
{
  flake.modules.nixos.dae =
    { config, pkgs, ... }:
    {
      services.dae = {
        enable = true;
        configFile = "/run/dae/config.dae";
      };

      sops.secrets.subscription = { };

      systemd.services.dae = {
        restartTriggers = [ config.sops.secrets.subscription.path ];

        serviceConfig = {
          LoadCredential = [ "" ];

          RuntimeDirectory = "dae";
          RuntimeDirectoryMode = "0700";
          ReadWritePaths = [ "/run/dae" ];

          ExecStartPre = [
            ""
            (pkgs.writeShellScript "prepare-dae-config" ''
              SUB_URL=$(cat ${config.sops.secrets.subscription.path})

              cat <<EOF > /run/dae/config.dae
              ${daeConfigTemplate "$SUB_URL"}
              EOF

              chmod 600 /run/dae/config.dae
            '')
          ];

          ExecStart = [
            ""
            "${pkgs.dae}/bin/dae run -c /run/dae/config.dae"
          ];
        };
      };
    };
}
