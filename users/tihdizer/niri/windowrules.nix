{ ... }:
{
  flake.modules.homeManager.tihdizer-niri-windowrules =
    { ... }:
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

          #= All Monitors
          {
            matches = [
              {
                title = "empty project";
                app-id = "dev.zed.Zed-Nightly";
              }
              { app-id = "jetbrains-rustrover"; }
              {
                app-id = "obsidian";
              }
            ];
            default-column-width = {
              proportion = 2. / 3.;
            };
          }

          {
            matches = [
              { app-id = "org.pulseaudio.pavucontrol"; }
              { app-id = "com.saivert.pwvucontrol"; }
            ];
            open-floating = true;
            default-floating-position = {
              x = 0;
              y = 180;
              relative-to = "top";
            };
            default-column-width = {
              proportion = 2. / 3.;
            };
            default-window-height = {
              proportion = 2. / 3.;
            };
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

          #= Primary Monitor (DP-3)
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

          {
            matches = [ { app-id = ".virt-manager-wrapped"; } ];
            open-on-output = "DP-3";
          }

          #= Secondary Monitor (DP-5)
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

          {
            matches = [
              { app-id = "io.github.ilya_zlobintsev.LACT"; }
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
            ];
            open-on-output = "DP-5";
            default-column-width = {
              proportion = 1. / 3.;
            };
          }

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

          {
            matches = [
              {
                title = "notificationtoasts";
                app-id = "steam";
              }
            ];
            open-floating = true;
            default-floating-position = {
              x = 10;
              y = 10;
              relative-to = "bottom-right";
            };
            open-on-output = "DP-5";
            open-focused = false;
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
            block-out-from = "screencast";
          }
        ];
      };
    };
}
