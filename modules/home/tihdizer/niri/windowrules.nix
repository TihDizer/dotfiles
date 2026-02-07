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
    # See app-id with command = $ niri msg windows
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
      {
        # todo: dont work
        matches = [ { app-id = "dev.zed.Zed"; } ];
        default-column-width = {
          proportion = 2. / 3.;
        };
      }
      #= Steam and Games
      {
        matches = [ { app-id = "steam"; } ];
        open-on-output = "DP-5";
        default-column-width = {
          proportion = 1.0;
        };
      }
      {
        matches = [
          {
            title = "Friends List";
            app-id = "steam";
          }
        ];
        default-column-width = {
          proportion = 2. / 3.;
        };
      }
      {
        matches = [ { app-id = "dota2"; } ];
        open-on-output = "DP-3";
      }
      {
        matches = [ { app-id = "^discord(_canary)?$"; } ];
        open-on-output = "DP-5";
      }
      #= Browsers
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
      #= Terminal Emulators
      {
        matches = [ { app-id = "org.wezfurlong.wezterm"; } ];
        default-column-width = {
          proportion = 1.0;
        };
      }
      {
        matches = [
          {
            title = "yazi";
            app-id = "alacritty";
          }
        ];
        default-column-width = {
          proportion = 0.25;
        };
      }
      #= Waydroid
      {
        matches = [ { app-id = "Waydroid"; } ];
        default-column-width = {
          fixed = 1256;
        };
      }
    ];
  };
}
