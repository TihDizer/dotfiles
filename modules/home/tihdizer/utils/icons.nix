{ pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    papirus-folders
    bibata-cursors
  ];
}
