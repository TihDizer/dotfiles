{ ... }:
{
  flake.modules.homeManager.tihdizer-utils-packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fastfetch # System info display
        cosmic-files # Wayland file manager
        qbittorrent # BitTorrent client
        postman # API client
        codex # AI code assistant
      ];

      programs.btop = {
        enable = true;
        package = pkgs.btop.override {
          rocmSupport = true;
        };
      };
    };
}
