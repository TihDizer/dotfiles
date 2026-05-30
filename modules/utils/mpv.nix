{ ... }:
{
  flake.modules.homeManager.mpv =
    { pkgs, ... }:
    {
      programs.mpv = {
        enable = true;
        config = {
          save-position-on-quit = true;
        };
      };

      home.packages = with pkgs; [
        jellyfin-ffmpeg
      ];
    };
}
