{ ... }:
{
  flake.modules.homeManager.mpv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mpv
        jellyfin-ffmpeg
      ];
    };
}
