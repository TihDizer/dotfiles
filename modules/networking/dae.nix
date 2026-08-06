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
      tcp_check_url: 'http://cp.cloudflare.com'
      tcp_check_http_method: HEAD
      udp_check_dns: '8.8.8.8:53'
      check_interval: 30s
      check_tolerance: 50ms
      disable_waiting_network: true
      bandwidth_max_tx: '500 mbps'
      bandwidth_max_rx: '500 mbps'
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
        filter: !name(regex: '.*Россия.*')
        filter: !name(regex: '.*🇷🇺.*')
        policy: min_moving_avg
      }

      germany {
        filter: name(regex: '.*Германия.*')
        filter: name(regex: '.*🇩🇪.*')
        policy: min_moving_avg
      }

      youtube {
        filter: !name(regex: '.*Россия.*')
        filter: !name(regex: '.*🇷🇺.*')
        policy: min_moving_avg
      }

      kazakhstan {
        filter: name(regex: '.*Казахстан.*')
        filter: name(regex: '.*🇰🇿.*')
        policy: min_moving_avg
      }
    }

    routing {
      #system
      pname(NetworkManager) -> direct
      dip(224.0.0.0/3, 'ff00::/8') -> direct
      dip(geoip:private) -> direct

      ipversion(6) -> block
      # l4proto(udp) && dport(443) -> block

      dip(77.88.8.8) -> direct
      dip(geoip:ru) -> direct
      domain(suffix: ru, suffix: su, suffix: xn--p1ai) -> direct
      domain(nixos.org, nix.dev, search.nixos.org) -> direct

      #proxy
      domain(geosite:discord) -> proxy
      domain(suffix: oxfordlearnersdictionaries.com, suffix: oxforddictionaries.com, suffix: oup.com) -> proxy
      domain(suffix: annas-archive.li, suffix: b4mcx2ml.net, suffix: britishcouncil.org, suffix: chatgpt.com, suffix: dashboard.kick.com, suffix: dub.co, suffix: givefreely.com, suffix: google.zoom.us, suffix: kick.com, suffix: linkedin.com, suffix: partners.dub.co, suffix: perplexity.ai, suffix: throne.me, suffix: trustedhousesitters.com, suffix: whatismyipaddress.com, suffix: zoom.us, suffix: app.zoom.us) -> proxy
      domain(suffix: amazonaws.com, suffix: b-cdn.net, suffix: throne.me) -> proxy
      domain(suffix: t.me, suffix: telegram.org, suffix: telegram.dog, geosite: telegram) -> proxy
      domain(suffix: speedtest.net) -> proxy
      domain(suffix: 1flex.org, suffix: primevideo.com, suffix: roku.com, suffix: justwatch.com, suffix: ororo.tv, suffix: amazon.com) -> proxy
      domain(suffix: kinozal.tv, suffix: kinozal.me ) -> proxy
      domain(suffix: tor4me.info, suffix: tor2me.info, torrent4me.com, retracker.local) -> proxy
      domain(suffix: jetbrains.com, suffix: openai.com, chatgpt.com, geosite: openai, suffix: coderfile.io) -> proxy

      pname(Telegram) -> proxy
      pname(.Telegram-wrapped) -> proxy

      #youtube
      domain(suffix: googlevideo.com, suffix: youtube.com, suffix: ytimg.com, suffix: youtu.be, suffix: ggpht.com, suffix: youtube-nocookie.com, geosite:youtube) -> youtube

      #germany
      domain(gemini.google.com, accounts.google.com, googleapis.com, gstatic.com, googleusercontent.com) -> germany
      domain(geosite:google) -> germany
      domain(suffix: ipinfo.io) -> germany
      domain(suffix: github.com, suffix: githubusercontent.com, suffix: githubcopilot.com) -> germany
      domain(suffix: tokenrouter.com) -> germany
      pname(agy) -> germany

      #kazakhstan
      domain(suffix: bybit.com, suffix: bybit.gl, suffix: bybit.biz, suffix: bybitglobal.com) -> kazakhstan

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
        reloadTriggers = [
          config.sops.templates."dae-config.dae".path
          (builtins.hashString "sha256" (daeConfigTemplate ""))
        ];
      };
    };
}
