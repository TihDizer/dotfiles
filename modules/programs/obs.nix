{ ... }:
{
  flake.modules.nixos.programs-obs =
    { ... }:
    {
      programs.obs-studio = {
        enable = true;
      };
    };

  flake.modules.homeManager.programs-obs =
    { ... }:
    {
      programs.obs-studio = {
        enable = true;
      };
    };
}
