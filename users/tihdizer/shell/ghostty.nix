{ ... }:
{
  flake.modules.homeManager.tihdizer-ghostty =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        settings = {
          keybind = [
            "global:super+escape=toggle_quick_terminal"
            "global:super+grave_accent=toggle_quick_terminal"
          ];
          quick-terminal-position = "top";
          quick-terminal-size = "40%";
          quick-terminal-animation-duration = 0.15;
          initial-window = false;
          quit-after-last-window-closed = false;
        };
      };
    };
}
