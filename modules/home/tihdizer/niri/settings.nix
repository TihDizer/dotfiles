{ config, ... }:
let
in
{
  programs.niri.settings = {
    layout = {
      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#74c7ec";
        inactive.color = "#585b70";
      };

      border.enable = false;

      center-focused-column = "on-overflow";

      background-color = "transparent";

      preset-window-heights = [
        { proportion = 1.; }
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
      ];

      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
        { proportion = 1.0; }
      ];

      default-column-width = {
        proportion = 1.0 / 3.0;
      };

      gaps = 4;
      struts = {
        left = 0;
        right = 0;
        top = 0;
        bottom = 0;
      };
      tab-indicator = {
        hide-when-single-tab = true;
        place-within-column = true;
        position = "left";
        corner-radius = 20.0;
        gap = -12.0;
        gaps-between-tabs = 10.0;
        width = 4.0;
        length.total-proportion = 0.1;
      };
    };

    gestures = {
      hot-corners.enable = false;
    };

    overview = {
      workspace-shadow = {
        enable = true;
        color = "#000000F2";
        softness = 100;
      };
      zoom = 0.70;
      backdrop-color = "00000040"; # transparent Changed for Black Color With 40% of Opacity
    };

    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
  };
}
