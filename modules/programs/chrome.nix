{ ... }:
{
  flake.modules.homeManager.programs-chrome =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        google-chrome
      ];
    };
}
