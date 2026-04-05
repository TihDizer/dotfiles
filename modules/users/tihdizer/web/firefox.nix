{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-web-firefox =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox;
      };
    };
}
