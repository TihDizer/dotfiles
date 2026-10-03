{ ... }:
{
  flake.modules.nixos.navidrome =
    { ... }:
    {
      users.users.navidrome = {
        isSystemUser = true;
        group = "navidrome";
      };

      users.groups.navidrome = { };

      services.navidrome = {
        enable = true;
        settings = {
          Address = "127.0.0.1";
          Port = 4533;
          MusicFolder = "/var/media/music";
          DataFolder = "/var/lib/navidrome";
          DefaultTheme = "Dark";
          EnableSharing = true;
          EnableInsightsCollector = false;
          Scanner.PurgeMissing = "always";
        };
      };
    };
}
