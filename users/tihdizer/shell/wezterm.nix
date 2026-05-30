{ ... }:
{
  flake.modules.homeManager.tihdizer-wezterm =
    { pkgs, ... }:
    {
      # imports = [ ./theme.nix ];
      programs.wezterm = {
        enable = true;
        package = pkgs.wezterm;
        extraConfig = ''
          local wezterm = require 'wezterm'
          local config = wezterm.config_builder()

          config.audible_bell = "Disabled"
          config.window_close_confirmation = "NeverPrompt"

          config.check_for_updates = false
          config.enable_wayland = true
          config.enable_tab_bar = false
          config.window_background_opacity = 1.0
          config.hide_tab_bar_if_only_one_tab = true

          -- Smooth cursor blink animations
          config.cursor_blink_ease_in = "EaseIn"
          config.cursor_blink_ease_out = "EaseOut"
          config.cursor_blink_rate = 500

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

          return config
        '';
      };

      # font = wezterm.font("${fonts.monospace.name}"),
      # font_size = ${toString fonts.sizes.terminal},
    };
}
