{
  config,
  pkgs,
  ...
}:
# let
#   fonts = config.stylix.fonts;
# in
{
  # imports = [ ./theme.nix ];
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}
      config.audible_bell = "Disabled"
      config.window_close_confirmation = "NeverPrompt"

      config.skip_close_confirmation_for_processes_named = {
        'bash',
        'sh',
        'zsh',
        'fish',
        'tmux',
        'nu',
        'cmd.exe',
        'pwsh.exe',
        'powershell.exe',
        'yazi',
        'btop',
      }

      wezterm.on('mux-is-process-stateful', function(_proc)
        return false
      end)

      return {
        check_for_updates = false,
        enable_wayland = true,
        enable_tab_bar = false,
        window_background_opacity = 1.0,
        hide_tab_bar_if_only_one_tab = true,
      }
    '';
  };

  # font = wezterm.font("${fonts.monospace.name}"),
  # font_size = ${toString fonts.sizes.terminal},
}
