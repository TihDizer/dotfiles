{ ... }:
{
  flake.modules.homeManager.programs-firefox =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox;
        profiles.default = { };
      };

      stylix.targets.firefox.profileNames = [ "default" ];
    };
}
