{ ... }:
{
  flake.modules.nixos.navidrome =
    { pkgs, ... }:
    {
      users.users.navidrome = {
        isSystemUser = true;
        group = "navidrome";
      };

      users.groups.navidrome = { };

      services.navidrome = {
        enable = true;
        
        plugins = [
          pkgs.pkgsCross.wasi32.navidromePlugins.lyrics-plugin
        ];

        settings = {
          Address = "127.0.0.1";
          Port = 4533;
          MusicFolder = "/var/media/music";
          DataFolder = "/var/lib/navidrome";
          DefaultTheme = "Dark";
          EnableSharing = true;
          EnableInsightsCollector = false;
          ScanSchedule = "@every 10m";
          
          LyricsPriority = "embedded,lyrics-plugin";
        };
      };
    };
}
