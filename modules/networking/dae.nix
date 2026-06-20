{ ... }:

{
  flake.modules.nixos.dae =
    { ... }:
    {
      services.dae = {
        enable = true;
        config = ''
          global {
            lan_interface: auto
            wan_interface: auto
            log_level: info
            dial_mode: ip
          }

          subscription {
            proxy: 'env://DAE_SUB_URL'
          }

          group {
            proxy {
              filter: subtag(proxy)
              policy: min_moving_avg
            }
          }

          routing {
            dip(224.0.0.0/3, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 127.0.0.0/8) -> direct

            pname(.Discord-wrapped) -> proxy
            pname(.Telegram-wrapped) -> proxy

            domain(nixos.org, nix.dev, search.nixos.org) -> direct
            domain(kick.com, dashboard.kick.com, givefreely.com, trustedhousesitters.com, perplexity.ai, linkedin.com, britishcouncil.org, whatismyipaddress.com, b4mcx2ml.net, notebooklm.google, chatgpt.com, zoom.us, app.zoom.us, google.zoom.us, dub.co, partners.dub.co, annas-archive.li) -> proxy
            domain(suffix: amazonaws.com, suffix: google.com, suffix: b-cdn.net) -> proxy

            fallback: direct
          }
        '';
      };
    };
}
