{ inputs, ... }:
{
  flake.modules.homeManager.tihdizer-shell = {
    imports = with inputs.self.modules.homeManager; [
      tihdizer-shell-wezterm
      tihdizer-shell-session-variables
      tihdizer-shell-starship
      tihdizer-shell-fish
    ];
  };
}
