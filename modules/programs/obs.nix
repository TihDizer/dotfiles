{ ... }:
{
  flake.modules.nixos.obs =
    { ... }:
    {
      programs.obs-studio = {
        enable = true;
      };
    };

  flake.modules.homeManager.obs =
    { ... }:
    {
      programs.obs-studio = {
        enable = true;
      };
    };
}
