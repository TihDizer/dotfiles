{ ... }:
{
  flake.modules.homeManager.tihdizer-utils-icons =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        papirus-icon-theme
        papirus-folders
        bibata-cursors
      ];
    };
}
