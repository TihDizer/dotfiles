{ ... }:
{
  flake.modules.homeManager.tihdizer-utils-apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cosmic-files # Wayland file manager
        mission-center # System monitor GUI
        qbittorrent # BitTorrent client
        postman
        codex
      ];
    };
}
