{ ... }:
{
  flake.modules.homeManager.tihdizer-icons =
    { pkgs, ... }:
    {
      # TODO: check this pkgs
      home.packages = with pkgs; [
        papirus-icon-theme
        papirus-folders
        bibata-cursors
      ];
    };
}
