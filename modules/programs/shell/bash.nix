{ ... }:
{
  flake.modules.nixos.programs-shell-bash =
    { ... }:
    {
      programs.bash = {
        enable = true;
        completion.enable = true;
      };
    };

  flake.modules.homeManager.programs-shell-bash =
    { ... }:
    {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    };
}
