{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-home =
    { ... }:
    {
      home.username = "tihdizer";
      home.homeDirectory = "/home/tihdizer";
      home.stateVersion = "25.05";

      # TODO: check stateVersion
      gtk.gtk4.theme = null;
      xdg.userDirs.setSessionVariables = false;
    };
}
