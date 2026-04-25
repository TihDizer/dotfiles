{ ... }:
{
  flake.modules.nixos.bash =
    { ... }:
    {
      programs.bash = {
        enable = true;
        completion.enable = true;
      };
    };

  flake.modules.homeManager.bash =
    { ... }:
    {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    };
}
