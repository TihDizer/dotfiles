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
      dial_mode: domain
      tls_implementation: utls
      utls_imitate: chrome_auto
      tcp_check_url: 'http://cp.cloudflare.com,1.1.1.1'
      tcp_check_http_method: HEAD
      udp_check_dns: '8.8.8.8:53'
      check_interval: 30s
      check_tolerance: 50ms
      disable_waiting_network: true
    }

    subscription {
      proxy: '${subscriptionUrl}'
    }

    dns {
      ipversion_prefer: 4
      upstream {
        googledns: 'tcp+udp://8.8.8.8:53'
        landns: 'tcp+udp://77.88.8.8:53'
      }
      routing {
        request {
          qtype(https) -> reject
          qtype(aaaa) -> reject
          qname(suffix: ru, suffix: su, suffix: xn--p1ai) -> landns
          fallback: googledns
        }
        response {
          fallback: accept
        }
      }
    }

    group {
      proxy {
        filter: !name(regex: '(?i).*(support|info|chat|канал|hysteria|grpc|⛔️|россия).*')
        policy: min_moving_avg
      }

      germany {
        filter: name(regex: '.*(Германия|🇩🇪).*') && !name(regex: '(?i).*(support|info|chat|канал|hysteria|grpc|⛔️).*')
        policy: min_moving_avg
      }

      youtube {
        filter: !name(regex: '(?i).*(support|info|chat|канал|hysteria|grpc|⛔️|россия).*') && !name(keyword: 'россия', '🇷🇺')
        policy: min_moving_avg
      }

      kazakhstan {
        filter: name(regex: '.*(Казахстан|🇰🇿).*') && !name(regex: '(?i).*(support|info|chat|канал|hysteria|grpc|⛔️).*')
        policy: min_moving_avg
      }
    }

    routing {
      #system
      pname(NetworkManager) -> direct
      dip(224.0.0.0/3, 'ff00::/8') -> direct
      dip(geoip:private) -> direct
      l4proto(udp) && dport(443) -> block
      ipversion(6) -> block

      dip(77.88.8.8) -> direct
      dip(geoip:ru) -> direct
      domain(suffix: ru, suffix: su, suffix: xn--p1ai) -> direct
      domain(nixos.org, nix.dev, search.nixos.org) -> direct

      #youtube
      domain(geosite:youtube) -> youtube
      domain(suffix: googlevideo.com, suffix: youtube.com, suffix: ytimg.com, suffix: youtu.be, geosite:youtube) -> youtube

      #germany
      domain(gemini.google.com, accounts.google.com, googleapis.com, gstatic.com, googleusercontent.com) -> germany
      pname(agy) -> germany

      #kazakhstan
      domain(suffix: bybit.com, suffix: bybit.gl, suffix: bybit.biz, suffix: bybitglobal.com) -> kazakhstan

      #proxy
      domain(geosite:discord) -> proxy
      domain(annas-archive.li, b4mcx2ml.net, britishcouncil.org, chatgpt.com, dashboard.kick.com, dub.co, givefreely.com, google.zoom.us, kick.com, linkedin.com, partners.dub.co, perplexity.ai, throne.me, trustedhousesitters.com, whatismyipaddress.com, zoom.us, app.zoom.us) -> proxy
      domain(suffix: amazonaws.com, suffix: b-cdn.net, suffix: throne.me) -> proxy
      domain(suffix: t.me, suffix: telegram.org, suffix: telegram.dog, geosite: telegram) -> proxy
      domain(suffix: speedtest.net) -> proxy
      domain(suffix: 1flex.org, suffix: primevideo.com, suffix: roku.com, suffix: justwatch.com, suffix: ororo.tv, suffix: amazon.com) -> proxy
      domain(suffix: kinozal.tv) -> proxy
      domain(suffix: tor4me.info, suffix: tor2me.info, torrent4me.com, retracker.local) -> proxy
      domain(suffix: jetbrains.com, suffix: openai.com, chatgpt.com, geosite: openai) -> proxy
      domain(suffix: github.com) -> proxy

      pname(Telegram) -> proxy
      pname(.Telegram-wrapped) -> proxy

      #direct
      pname(.transmission-q) -> direct
      domain(suffix: local, keyword: torrent) -> direct

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
