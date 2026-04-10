{ ... }:
{
  flake.modules.homeManager.utils-mpv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mpv
        jellyfin-ffmpeg
      ];
    };
}
