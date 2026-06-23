{ ... }:
{
  flake.modules.homeManager.chrome =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        google-chrome
      ];
      programs.google-chrome = {
        enable = true;
        extraOpts = {
          "RestoreOnStartup" = 1;
        };
      };
    };
}
