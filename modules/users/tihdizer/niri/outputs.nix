{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-niri-outputs =
    { ... }:
    {
      #= Displays
      programs.niri.settings.outputs = {
        # Primary
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
          };
        };

        # Secondary
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
          };
        };

        # TV
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
          };
        };
      };
    };
}
