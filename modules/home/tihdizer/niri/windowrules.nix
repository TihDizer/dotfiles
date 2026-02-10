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
    #= Workspaces
    workspaces = {
      # Primary output
      medias = {
        name = "medias";
        open-on-output = "DP-3";
      };
      devs = {
        name = "devs";
        open-on-output = "DP-3";
      };
      games = {
        name = "games";
        open-on-output = "DP-3";
      };
      vms = {
        name = "vms";
        open-on-output = "DP-3";
      };

      # Secondary output
      chats = {
        name = "chats";
        open-on-output = "DP-5";
      };
      docs = {
        name = "tools";
        open-on-output = "DP-5";
      };
      launchers = {
        name = "launchers";
        open-on-output = "DP-5";
      };

      #TV todo: kanshi mb
      tv = {
        name = "tv";
        open-on-output = "HDMI-A-1";
      };
    };

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
        matches = [ { app-id = "zed"; } ];
        open-on-workspace = "devs";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      {
        matches = [ { app-id = "jetbrains-rustrover"; } ];
        open-on-workspace = "devs";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      #= Games
      {
        matches = [ { app-id = "^steam_app_\\d+"; } ]; # Steam pattern to test
        open-on-workspace = "games";
      }

      {
        matches = [ { app-id = "dota2"; } ];
        open-on-workspace = "games";
        open-on-output = "DP-3";
      }

      {
        matches = [
          { title = "Geometry Dash"; }
        ];
        open-on-workspace = "games";
      }

      #= VMs
      {
        matches = [ { app-id = ".virt-manager-wrapped"; } ];
        open-on-workspace = "vms";
        open-on-output = "DP-3";
      }

      #= Chats
      {
        matches = [ { app-id = "^discord(_canary)?$"; } ];
        open-on-workspace = "chats";
        open-on-output = "DP-5";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      {
        matches = [ { app-id = "org.telegram.desktop"; } ];
        default-column-width = {
          proportion = 1. / 3.;
        };
        block-out-from = "screencast";
        open-on-workspace = "chats";
        open-on-output = "DP-5";
      }

      #= Tools
      {
        matches = [ { app-id = "io.github.ilya_zlobintsev.LACT"; } ];
        open-on-workspace = "tools";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      {
        matches = [ { app-id = ".blueman-manager-wrapped"; } ];
        open-on-workspace = "tools";
        default-column-width = {
          proportion = 1. / 3.;
        };
      }

      {
        matches = [ { app-id = "org.pulseaudio.pavucontrol"; } ];
        open-on-workspace = "tools";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      {
        matches = [ { app-id = "Throne"; } ];
        open-on-workspace = "tools";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      #= Launchers
      {
        matches = [ { app-id = "steam"; } ];
        open-on-output = "DP-5";
        open-on-workspace = "launchers";
        default-column-width = {
          proportion = 2. / 3.;
        };
      }

      {
        matches = [
          {
            title = "Friends List";
            app-id = "steam";
          }
        ];
        open-on-workspace = "launchers";
        default-column-width = {
          proportion = 1. / 3.;
        };
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
            app-id = "^(firefox|chromium-browser|chrome-.*|firefox-.*)$";
            at-startup = true;
          }
        ];
        default-column-width = {
          proportion = 2. / 3.;
        };
        open-on-workspace = "medias";
      }
    ];
  };
}
