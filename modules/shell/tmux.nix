{ ... }:
{
  flake.modules.nixos.tmux =
    { ... }:
    {
      programs.tmux.enable = true;
    };

  flake.modules.homeManager.tmux =
    {
      config,
      options,
      lib,
      pkgs,
      ...
    }:
    let
      colors =
        if config ? lib.stylix then
          config.lib.stylix.colors.withHashtag
        else
          {
            base00 = "#272e33";
            base01 = "#2e383c";
            base02 = "#414b50";
            base03 = "#859289";
            base04 = "#9da9a0";
            base05 = "#d3c6aa";
            base06 = "#edeada";
            base07 = "#fffbef";
            base08 = "#e67e80";
            base09 = "#e69875";
            base0A = "#dbbc7f";
            base0B = "#a7c080";
            base0C = "#83c092";
            base0D = "#7fbbb3";
            base0E = "#d699b6";
            base0F = "#9da9a0";
          };

      homeDir = config.home.homeDirectory or "/home/${config.home.username or "tihdizer"}";
      shortPwd = "#{s|^${homeDir}|~|;s|^/home/[^/]+|~|;s|/(\\.?[^/.])[^/]+/|/\\\\1/|;s|/(\\.?[^/.])[^/]+/|/\\\\1/|;s|/(\\.?[^/.])[^/]+/|/\\\\1/|;s|/(\\.?[^/.])[^/]+/|/\\\\1/|;s|/(\\.?[^/.])[^/]+/|/\\\\1/|;s|/(\\.?[^/.])[^/]+/|/\\\\1/|;s|/(\\.?[^/.])[^/]+/|/\\\\1/|;s|/(\\.?[^/.])[^/]+/|/\\\\1/|:pane_current_path}";
    in
    {
      stylix = lib.mkIf (options ? stylix) {
        targets.tmux.enable = false;
      };

      programs.tmux = {
        enable = true;
        baseIndex = 1;
        keyMode = "vi";
        mouse = true;
        escapeTime = 0;
        historyLimit = 50000;
        terminal = "tmux-256color";

        plugins = with pkgs.tmuxPlugins; [
          sensible
          vim-tmux-navigator
          yank
        ];

        extraConfig = ''
          set -g status-position bottom
          set -g status-style "bg=default"
          set -g status-justify left
          set -g status-left-length 50
          set -g status-right-length 100
          set -g renumber-windows on
          set -g automatic-rename on
          set -g automatic-rename-format "#{pane_current_command}"

          set -g window-status-separator " "
          set -g status-left "#[fg=#{?client_prefix,${colors.base08},${colors.base0B}},bg=default]#[fg=${colors.base00},bg=#{?client_prefix,${colors.base08},${colors.base0B}},bold] #S #[fg=#{?client_prefix,${colors.base08},${colors.base0B}},bg=default] "
          set -g window-status-current-format "#[fg=${colors.base0A},bg=default]#[fg=${colors.base00},bg=${colors.base0A},bold] #I #W #[fg=${colors.base0A},bg=default]"
          set -g window-status-format "#[fg=${colors.base02},bg=default]#[fg=${colors.base04},bg=${colors.base02}] #I #W #[fg=${colors.base02},bg=default]"
          set -g status-right "#[fg=${colors.base02},bg=default]#[fg=${colors.base05},bg=${colors.base02}]  ${shortPwd} #[fg=${colors.base02},bg=default] #[fg=${colors.base02},bg=default]#[fg=${colors.base0D},bg=${colors.base02}] 󰃰 %H:%M #[fg=${colors.base02},bg=default]"

          set -g pane-border-style "fg=${colors.base02}"
          set -g pane-active-border-style "fg=${colors.base0D}"
          set -as terminal-features ",*:RGB"

          bind '"' split-window -v -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"
          bind | split-window -h -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"
          bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
        '';
      };

      programs.zsh.initContent = lib.mkAfter ''
        [[ -n "$TMUX" ]] && export STARSHIP_CONFIG="$HOME/.config/starship-tmux.toml"

        if [[ -z "$TMUX" && -n "$PS1" && -z "$SSH_CONNECTION" ]]; then
          exec tmux new-session -A -s main
        fi
      '';

      programs.fish.interactiveShellInit = lib.mkAfter ''
        set -q TMUX; and set -gx STARSHIP_CONFIG "$HOME/.config/starship-tmux.toml"

        if status is-interactive; and not set -q TMUX; and test -z "$SSH_CONNECTION"
          exec tmux new-session -A -s main
        end
      '';
    };
}
