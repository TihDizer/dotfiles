{ inputs, ... }:
{
  flake.modules.nixos.programs-shell = {
    imports = with inputs.self.modules.nixos; [
      programs-shell-fish
      programs-shell-zsh
      programs-shell-bash
    ];
  };

  flake.modules.homeManager.programs-shell = {
    imports = with inputs.self.modules.homeManager; [
      programs-shell-fish
      programs-shell-zsh
      programs-shell-bash
    ];
  };
}
