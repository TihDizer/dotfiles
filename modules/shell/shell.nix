{ inputs, ... }:
{
  flake.modules.nixos.shell = {
    imports = with inputs.self.modules.nixos; [
      fish
      zsh
      bash
      nushell
      cli
      kitty
      fastfetch
      macchina
      tmux
      atuin
    ];
  };

  flake.modules.homeManager.shell = {
    imports = with inputs.self.modules.homeManager; [
      fish
      zsh
      bash
      nushell
      cli
      kitty
      fastfetch
      macchina
      tmux
      atuin
    ];
  };
}
