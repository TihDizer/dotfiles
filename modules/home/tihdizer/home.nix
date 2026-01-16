{
  config,
  pkgs,
  ...
}:

{
  home.username = "tihdizer";
  home.homeDirectory = "/home/tihdizer";
  home.stateVersion = "25.05";

  programs.bash.enable = true;
}
