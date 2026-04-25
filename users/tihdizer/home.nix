{ ... }:
{
  flake.modules.homeManager.tihdizer-home =
    { ... }:
    {
      home.username = "tihdizer";
      home.homeDirectory = "/home/tihdizer";
      home.stateVersion = "26.05";
    };
}
