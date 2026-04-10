{ ... }:
{
  flake.modules.homeManager.programs-firefox =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox;
      };
    };
}
