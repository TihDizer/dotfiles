{ ... }:
{
  flake.modules.homeManager.tihdizer-niri-binds =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib) getExe mkMerge;
      wpctl = "${pkgs.wireplumber}/bin/wpctl";
      playerctl = "${pkgs.playerctl}/bin/playerctl";
      launcher = "${pkgs.walker}/bin/walker";
      browser = getExe pkgs.google-chrome;
      term = getExe pkgs.wezterm;
      volume = getExe pkgs.pavucontrol;
      # lock = getExe pkgs.hyprlock;
      # logout = getExe pkgs.wlogout;
    in
    {
      programs.niri.settings.binds =
        with config.lib.niri.actions;
        mkMerge [
          {
            #= Audio
            "XF86AudioMute".action.spawn = [
              wpctl
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
            "XF86AudioMicMute".action.spawn = [
              wpctl
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ];
            "XF86AudioRaiseVolume".action.spawn = [
              wpctl
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "5%+"
            ];
            "XF86AudioLowerVolume".action.spawn = [
              wpctl
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "5%-"
            ];

            "XF86AudioPlay".action.spawn = [
              playerctl
              "play-pause"
            ];
            "XF86AudioStop".action.spawn = [
              playerctl
              "pause"
            ];
            "XF86AudioPrev".action.spawn = [
              playerctl
              "previous"
            ];
            "XF86AudioNext".action.spawn = [
              playerctl
              "next"
            ];

            #= Launch/Spawn Software
            "Mod+T".action.spawn = [ term ];
            "Mod+E".action.spawn = [
              term
              "-e"
              "yazi"
            ];
            "Mod+B".action.spawn = [ browser ];
            "Mod+D".action.spawn = [ launcher ];
            "Mod+P".action.spawn = [ volume ];
            # "Mod+Shift+Q".action.spawn = [ lock ];
            # "Mod+Shift+M".action.spawn = [ logout ];

            #= Screenshots
            "Mod+Shift+S".action.screenshot.show-pointer = true;
            "Mod+Ctrl+S".action.screenshot-window.write-to-disk = true;

            #= Actions
            "Mod+W".action = toggle-column-tabbed-display;
            "Mod+O".action = toggle-overview;
            "Mod+Q".action = close-window;
            "Mod+R".action = switch-preset-column-width;
            "Mod+Ctrl+R".action = reset-window-height;
            "Mod+Shift+R".action = switch-preset-window-height;
            "Mod+F".action = maximize-column;
            "Mod+Ctrl+F".action = expand-column-to-available-width;
            "Mod+Shift+F".action = fullscreen-window;
            "Mod+V".action = toggle-window-floating;
            "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

            "Mod+Shift+Slash".action = show-hotkey-overlay;

            "Mod+Comma".action = consume-or-expel-window-left;
            "Mod+Period".action = consume-or-expel-window-right;
            "Mod+C".action = center-column;
            "Mod+Ctrl+C".action = center-visible-columns;

            #= Screen Mirror (Test) # wl-present mirror eDP-1 --fullscreen-output HDMI-A-1 --fullscreen
            #"Mod+Shift+M".action.spawn = ["wl-present" "mirror" "eDP-1" "--fullscreen-output" "HDMI-A-1" "--fullscreen"];

            #= Focus Windows
            "Mod+H".action = focus-column-left;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;
            "Mod+L".action = focus-column-right;

            "Mod+U".action = focus-workspace-down;
            "Mod+I".action = focus-workspace-up;

            "Mod+Home".action = focus-column-first;
            "Mod+End".action = focus-column-last;

            "Mod+Shift+H".action = focus-monitor-left;
            "Mod+Shift+L".action = focus-monitor-right;
            "Mod+Shift+K".action = focus-monitor-up;
            "Mod+Shift+J".action = focus-monitor-down;

            #= Move Windows
            "Mod+Ctrl+H".action = move-column-left;
            "Mod+Ctrl+J".action = move-window-down;
            "Mod+Ctrl+K".action = move-window-up;
            "Mod+Ctrl+L".action = move-column-right;

            "Mod+Ctrl+U".action = move-column-to-workspace-down;
            "Mod+Ctrl+I".action = move-column-to-workspace-up;

            "Mod+Ctrl+Home".action = move-column-to-first;
            "Mod+Ctrl+End".action = move-column-to-last;

            "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
            "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
            "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
            "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;

            "Mod+1".action.focus-workspace = 1;
            "Mod+2".action.focus-workspace = 2;
            "Mod+3".action.focus-workspace = 3;
            "Mod+4".action.focus-workspace = 4;
            "Mod+5".action.focus-workspace = 5;
            "Mod+6".action.focus-workspace = 6;
            "Mod+7".action.focus-workspace = 7;
            "Mod+8".action.focus-workspace = 8;
            "Mod+9".action.focus-workspace = 9;
            "Mod+Ctrl+1".action.move-window-to-workspace = 1;
            "Mod+Ctrl+2".action.move-window-to-workspace = 2;
            "Mod+Ctrl+3".action.move-window-to-workspace = 3;
            "Mod+Ctrl+4".action.move-window-to-workspace = 4;
            "Mod+Ctrl+5".action.move-window-to-workspace = 5;
            "Mod+Ctrl+6".action.move-window-to-workspace = 6;
            "Mod+Ctrl+7".action.move-window-to-workspace = 7;
            "Mod+Ctrl+8".action.move-window-to-workspace = 8;
            "Mod+Ctrl+9".action.move-window-to-workspace = 9;

            "Mod+Tab".action = focus-workspace-previous;
          }
        ];
    };
}
