{
  programs.niri.settings = {
    layer-rules = [
      #= Wallpaper
      {
        matches = [ { namespace = "^wpaperd-HDMI-A-1$"; } ];
        place-within-backdrop = true;
      }
      {
        matches = [ { namespace = "^wpaperd-eDP-1$"; } ];
        place-within-backdrop = true;
      }
    ];

    # See app-id with command = $ niri msg windows / niri msg pick-window
    window-rules = [
      {
        geometry-corner-radius =
          let
            radius = 12.0;
          in
          {
            bottom-left = radius;
            bottom-right = radius;
            top-left = radius;
            top-right = radius;
          };
        clip-to-geometry = true;
      }

      #= Medias

      #= Devs
      {
        # todo: dont work
        matches = [
          { app-id = "^dev.zed.Zed-Nightly$"; }
          { title = "empty project"; }
        ]; # todo
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      {
        matches = [ { app-id = "jetbrains-rustrover"; } ];
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      #= Games
      {
        matches = [
          { app-id = "^steam_app_\\d+"; }
          { app-id = "dota2"; }
          { app-id = "cs2"; }
          { title = "^Geometry Dash$"; }
        ];
        open-on-output = "DP-3";
        open-focused = false;
      }

      #= VMs
      {
        matches = [ { app-id = ".virt-manager-wrapped"; } ];
        open-on-output = "DP-3";
      }

      #= Chats
      {
        matches = [ { app-id = "^discord(_canary)?$"; } ];
        open-on-output = "DP-5";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      {
        matches = [
          {
            app-id = "org.telegram.desktop";
            title = "Telegram";
          }
        ];
        default-column-width = {
          proportion = 1. / 3.;
        };
        block-out-from = "screencast";
        open-on-output = "DP-5";
      }

      #= Tools
      {
        matches = [
          { app-id = "io.github.ilya_zlobintsev.LACT"; }
          { app-id = "org.pulseaudio.pavucontrol"; }
          { app-id = "Throne"; }
          {
            title = "qBittorrent";
            app-id = "org.qbittorrent.qBittorrent";
          }
        ];
        open-on-output = "DP-5";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      {
        matches = [
          { app-id = ".blueman-manager-wrapped"; }
          { app-id = "com.saivert.pwvucontrol"; }
        ];
        open-on-output = "DP-5";
        default-column-width = {
          proportion = 1. / 3.;
        };
      }

      #= Launchers
      {
        matches = [
          {
            title = "Steam";
            app-id = "steam";
          }
          {
            title = "Special Offers";
            app-id = "steam";
          }
          {
            title = "Launching...";
            app-id = "steam";
          }
        ];
        open-on-output = "DP-5";
        default-column-width = {
          proportion = 2. / 3.;
        };
        open-focused = false;
      }

      {
        matches = [
          {
            title = "Friends List";
            app-id = "steam";
          }
        ];
        open-on-output = "DP-5";
        default-column-width = {
          proportion = 1. / 3.;
        };
        open-focused = false;
      }

      #= Other (all workspaces)
      {
        matches = [
          { app-id = "^(firefox|chromium-browser|chrome-.*|firefox-.*)$"; }
          { app-id = "^(xdg-desktop-portal-gtk)$"; }
        ];
        scroll-factor = 0.5;
      }

      {
        matches = [ { title = "(?i)picture in picture"; } ];
        open-floating = true;
        default-floating-position = {
          x = 2;
          y = 2;
          relative-to = "bottom-right";
        };
        default-column-width = {
          proportion = 2. / 3.;
        };
        open-focused = false;
      }

      {
        matches = [
          {
            app-id = "obsidian";
            at-startup = true;
          }
        ];
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      #= Startup
      {
        matches = [
          {
            app-id = "^(firefox|chromium-browser|google-chrome|chrome-.*|firefox-.*)$";
            at-startup = true;
          }
        ];
        default-column-width = {
          proportion = 2. / 3.;
        };
        open-focused = false;
      }

      {
        matches = [
          {
            app-id = "org.telegram.desktop";
            at-startup = true;
          }
        ];
        default-column-width = {
          proportion = 1. / 3.;
        };
        open-focused = false;
      }
    ];
  };
}
