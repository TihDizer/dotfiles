{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope;
    capSysNice = true;
    args = [
      "-e"
      "--force-grab-cursor"
      "--expose-wayland" # = Support Wayland Clients
      "--rt" # = Use Realtime Scheduling
      # "--adaptive-sync" # = Vrr
    ];
  };
}
