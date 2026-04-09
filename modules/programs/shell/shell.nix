{ inputs, ... }:
{
  flake.modules.nixos.programs-shell = {
    imports = with inputs.self.modules.nixos; [
      programs-shell-fish
    ];
  };
}
