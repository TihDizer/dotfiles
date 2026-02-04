{
  #= Displays (твои мониторы)
  programs.niri.settings.outputs = {
    "DP-3" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = null;
      };
      scale = 1.0;
      position = {
        x = 0;
        y = 0;
      }; # Primary
    };

    "DP-5" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = null;
      };
      scale = 1.0;
      position = {
        x = 1920;
        y = 0;
      }; # Right
    };

    "HDMI-A-1" = {
      mode = {
        width = 3840;
        height = 2160;
        refresh = null;
      };
      scale = 2.0;
      position = {
        x = 0;
        y = -1080;
      }; # TV 4K
    };
  };
}
