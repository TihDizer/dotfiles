{ ... }:
{
  flake.modules.nixos.programs-shell-zsh =
    { ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
      };
    };

  flake.modules.homeManager.programs-shell-zsh =
    { ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
      };
    };
}
