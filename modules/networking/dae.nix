{ inputs, ... }:
let
  daeConfigTemplate = subscriptionUrl: ''
    global {
      tproxy_port: 12345
      tproxy_port_protect: true
      log_level: info
      wan_interface: auto
      lan_interface: auto
      auto_config_kernel_parameter: true
      dial_mode: domain++
      tls_implementation: utls
      utls_imitate: chrome_auto
      tcp_check_url: 'http://cp.cloudflare.com,1.1.1.1'
      tcp_check_http_method: GET
      # udp_check_dns: '8.8.8.8:53'
      check_interval: 30s
      check_tolerance: 50ms
    }

    subscription {
      proxy: '${subscriptionUrl}'
    }

    dns {
      ipversion_prefer: 4

      upstream {
        googledns: 'tcp://8.8.8.8:53'
        landns: 'tcp://77.88.8.8:53'
      }
      routing {
        request {
          qname(
            suffix: ru,
            suffix: su,
            suffix: xn--p1ai
          ) -> landns

          fallback: googledns
        }

        response {
          fallback: accept
        }
      }
    }

    group {
      proxy {
        filter: !name(regex: '(?i).*(support|info|chat|канал|hysteria|grpc|⛔️|россия|швеция|гейминг|франция).*')
        policy: min_avg10
      }

      google {
        filter: name(regex: '.*(Нидерланды).*')
        filter: name(regex: '.*(Германия).*') [add_latency: 100ms]
        filter: !name(regex: '(?i).*(support|info|chat|канал|hysteria|grpc|⛔️|россия|швеция).*') [add_latency: 200ms]
        policy: min_avg10
      }
    }

    routing {
      #system
      pname(
        NetworkManager
      ) -> direct

      dip(
        224.0.0.0/4,
        geoip:private,
        'ff00::/8'
      ) -> direct

      l4proto(udp) && dport(443) -> block

      dip(
        77.88.8.8,
        geoip:ru
      ) -> direct

      domain(
        suffix: ru,
        suffix: su,
        suffix: xn--p1ai
      ) -> direct

      #proxy
      domain(
        geosite:discord,
        geosite:github,
        geosite:openai,
        geosite:telegram,

        suffix: 1flex.org,
        suffix: amazon.com,
        suffix: amazonaws.com,
        suffix: annas-archive.li,
        suffix: b-cdn.net,
        suffix: b4mcx2ml.net,
        suffix: britishcouncil.org,
        suffix: cyberia.is,
        suffix: dub.co,
        suffix: exodus.desync.com,
        suffix: givefreely.com,
        suffix: glotorrents.pw,
        suffix: jetbrains.com,
        suffix: justwatch.com,
        suffix: kick.com,
        suffix: kinozal.me,
        suffix: kinozal.tv,
        suffix: leechers-paradise.org,
        suffix: linkedin.com,
        suffix: nixos.org,
        suffix: open.stealth.si,
        suffix: openbittorrent.com,
        suffix: opentrackr.org,
        suffix: ororo.tv,
        suffix: p4p.arenabg.com,
        suffix: perplexity.ai,
        suffix: primevideo.com,
        suffix: protondb.com,
        suffix: public.popcorn-tracker.org,
        suffix: retracker.local,
        suffix: roku.com,
        suffix: rutor.org,
        suffix: speedtest.net,
        suffix: thepiratebay.org,
        suffix: throne.me,
        suffix: tor2me.info,
        suffix: tor4me.info,
        suffix: torrent.eu.org,
        suffix: torrent.gresille.org,
        suffix: torrent4me.com,
        suffix: tracker.bittor.pw,
        suffix: tracker.coppersurfer.tk,
        suffix: tracker.dler.org,
        suffix: tracker.internetwarriors.net,
        suffix: trustedhousesitters.com,
        suffix: whatismyipaddress.com,
        suffix: zoom.us
      ) -> proxy

      pname(
        .Telegram-wrapped,
        Telegram
        discord
      ) -> proxy

      #google
      domain(
        geosite:google,
        geosite:youtube,

        suffix: youtube.com,
        suffix: youtube-nocookie.com,
        suffix: youtu.be,
        suffix: googlevideo.com,
        suffix: ytimg.com,
        suffix: youtubei.googleapis.com,
        suffix: youtube.googleapis.com,
        suffix: ggpht.com,
        suffix: googleusercontent.com
      ) -> proxy

      pname(
        agy
      ) -> proxy

      #fallback
      fallback: direct
    }
  '';
in
{
  flake-file.inputs = {
    daeuniverse = {
      url = "github:daeuniverse/flake.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.dae =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.daeuniverse.nixosModules.dae
      ];

      services.dae = {
        enable = true;
        configFile = config.sops.templates."dae-config.dae".path;
        package = inputs.daeuniverse.packages.${pkgs.stdenv.hostPlatform.system}.dae;
      };

      sops.secrets.subscription = { };

      sops.templates."dae-config.dae" = {
        content = daeConfigTemplate "${config.sops.placeholder.subscription}";
        mode = "0600";
        owner = "root";
      };

      systemd.services.dae = {
        restartTriggers = [
          config.sops.templates."dae-config.dae".path
          (builtins.hashString "sha256" (daeConfigTemplate ""))
        ];
      };
    };
}
