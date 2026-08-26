{ ... }:
{
  flake.modules.nixos.fish =
    { ... }:
    {
      programs.fish = {
        enable = true;
        generateCompletions = true;
        shellAbbrs = {
        };
      };
    };

  flake.modules.homeManager.fish =
    { ... }:
    {
      programs.fish = {
        enable = true;
        generateCompletions = true;
        shellAbbrs = {
        };
      };
    };
}
