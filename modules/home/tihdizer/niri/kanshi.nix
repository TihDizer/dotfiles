{ config, pkgs, ... }:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = [
      {
        name = "dp-only";

        output = [
          {
            criteria = "DP-5";
            status = "enable";
          }
          {
            criteria = "DP-3";
            status = "enable";
          }
        ];

        exec = ''
          niri msg action focus-workspace "medias"
          niri msg action move-workspace-to-monitor "DP-5"
          niri msg action move-workspace-to-index 1
        '';
      }

      {
        name = "with-tv";

        output = [
          {
            criteria = "DP-5";
            status = "enable";
          }
          {
            criteria = "DP-3";
            status = "enable";
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
          }
        ];

        exec = ''
          niri msg action focus-workspace "medias"
          niri msg action move-workspace-to-monitor "HDMI-A-1"
          niri msg action move-workspace-to-index 1
        '';
      }
    ];
  };
}
