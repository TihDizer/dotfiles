{ inputs, ... }:
{
  flake.modules.nixos.shell = {
    imports = with inputs.self.modules.nixos; [
      fish
      zsh
      bash
      cli
    ];
  };

  flake.modules.homeManager.shell = {
    imports = with inputs.self.modules.homeManager; [
      fish
      zsh
      bash
      cli
    ];
  };
}
