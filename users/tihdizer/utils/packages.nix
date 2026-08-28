{ ... }:
{
  flake.modules.homeManager.tihdizer-packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        transmission_4-qt # BitTorrent client
        codex # AI code assistant
        antigravity-cli # AI code assistant
        gtypist # Touch typing tutor
      ];
    };
}
