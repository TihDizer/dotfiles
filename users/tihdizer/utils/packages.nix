{ ... }:
{
  flake.modules.homeManager.tihdizer-packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fastfetch # System info display
        cosmic-files # Wayland file manager
        transmission # BitTorrent client
        codex # AI code assistant
        antigravity # AI code assistant
        gemini-cli # AI code assistant
      ];

      programs.btop = {
        enable = true;
        package = pkgs.btop.override {
          rocmSupport = true;
        };
      };
    };
}
