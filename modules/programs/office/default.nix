{ inputs, ... }:
{
  flake.modules.homeManager.programs-office = {
    imports = with inputs.self.modules.homeManager; [
      programs-obsidian
    ];
  };
}
