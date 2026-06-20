{ inputs, ... }:
{
  flake.modules.homeManager.tihdizer-shell = {
    imports = with inputs.self.modules.homeManager; [
      tihdizer-session-variables
      tihdizer-starship
      tihdizer-fish
      tihdizer-zsh
    ];
  };
}
