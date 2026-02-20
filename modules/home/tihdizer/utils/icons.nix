{ pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    papirus-folders
    ttf-font-awesome
    bibata-cursors
  ];
}
