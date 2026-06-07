{ ... }:
{
  flake.modules.homeManager.tihdizer-niri-startup =
    { pkgs, ... }:
    {
      programs.niri.settings.spawn-at-startup = [
        { sh = "systemctl --user reset-failed"; }
        { sh = "polkit-gnome-authentication-agent-1"; }
        { sh = "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2"; }
        { sh = "sway-audio-idle-inhibit"; }
        { sh = "$POLKIT_BIN"; }
        # { sh = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all"; }
        { sh = "uwsm finalize"; }
        { command = [ "${pkgs.google-chrome}/bin/google-chrome" ]; }
        { command = [ "${pkgs.telegram-desktop}/bin/Telegram" ]; }
        { sh = "Throne"; }
        { command = [ "${pkgs.ghostty}/bin/ghostty" ]; }
      ];
    };
}
