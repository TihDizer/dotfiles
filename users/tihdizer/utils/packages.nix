{ ... }:
{
  flake.modules.homeManager.tihdizer-packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fastfetch # System info display
        transmission_4-qt # BitTorrent client
        codex # AI code assistant
        telegram-desktop # Telegram desktop client
        antigravity-cli # AI code assistant
        gtypist # Touch typing tutor
      ];
    };
}
