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
      check_interval: 5m
      check_tolerance: 50ms
    }

    subscription {
      proxy: '${subscriptionUrl}'
    }

    dns {
      upstream {
        googledns: 'tcp+udp://dns.google:53'
      }
      routing {
        request {
          fallback: googledns
        }
      }
    }

    group {
      proxy {
        filter: subtag(proxy)
        policy: min_moving_avg
      }

      germany_proxy {
        filter: name(regex: '.*\\xd0\\x93\\xd0\\xb5\\xd1\\x80\\xd0\\xbc\\xd0\\xb0\\xd0\\xbd\\xd0\\xb8\\xd1\\x8f.*')
        filter: name(regex: '.*🇩🇪.*')
        policy: min_moving_avg
      }
    }

    routing {
      #system
      pname(NetworkManager) -> direct
      dip(224.0.0.0/3, 'ff00::/8') -> direct
      dip(geoip:private) -> direct

      l4proto(udp) && dport(443) -> block

      #direct
      domain(nixos.org, nix.dev, search.nixos.org) -> direct

      #germany_proxy
      domain(geosite:google) -> germany_proxy

      #proxy
      domain(suffix: discord.com, suffix: discordapp.com, suffix: discordapp.net, suffix: discord.gg) -> proxy
      domain(suffix: discord.media, suffix: discordcdn.com, suffix: discordstatus.com) -> proxy
      domain(annas-archive.li, b4mcx2ml.net, britishcouncil.org, chatgpt.com, dashboard.kick.com, dub.co, givefreely.com, google.zoom.us, kick.com, linkedin.com, partners.dub.co, perplexity.ai, throne.me, trustedhousesitters.com, whatismyipaddress.com, zoom.us, app.zoom.us) -> proxy
      domain(suffix: amazonaws.com, suffix: b-cdn.net, suffix: throne.me) -> proxy
      domain(suffix: t.me, suffix: telegram.org, suffix: telegram.dog) -> proxy
      domain(suffix: speedtest.net) -> proxy

      pname(Telegram) -> proxy
      pname(.Telegram-wrapped) -> proxy

      #direct
      fallback: direct
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
