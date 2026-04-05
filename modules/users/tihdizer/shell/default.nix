{ inputs, ... }:
{
  flake.modules.homeManager.hm-tihdizer-shell = {
    imports = with inputs.self.modules.homeManager; [
      hm-tihdizer-shell-wezterm
      hm-tihdizer-shell-session-variables
    ];
  };
}
