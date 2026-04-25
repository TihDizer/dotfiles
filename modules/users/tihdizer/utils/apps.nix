{ ... }:
{
  flake.modules.homeManager.tihdizer-utils-apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cosmic-files # Wayland file manager
        qbittorrent # BitTorrent client
        postman
        codex
      ];
    };
}
