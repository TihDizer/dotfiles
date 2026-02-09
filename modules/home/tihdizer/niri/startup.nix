{ pkgs, ... }:
{
  programs.niri.settings.spawn-at-startup = [
    { sh = "systemctl --user reset-failed"; }
    { sh = "polkit-gnome-authentication-agent-1"; }
    { sh = "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2"; }
    { sh = "sway-audio-idle-inhibit"; }
    { sh = "$POLKIT_BIN"; }
    { sh = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all"; }
  ];

  systemd.user.services.niri-workspaces = {
    Unit = {
      Description = "Niri workspace order";
      After = [
        "graphical-session.target"
        "niri.service"
      ];
      PartOf = [ "graphical-session.target" ];
      Wants = [ "niri.service" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "niri-order" ''
        #!/usr/bin/env bash
        sleep 5
        echo "Ordering workspaces..." | logger -t niri-order

        # Primary
        ${pkgs.niri}/bin/niri msg action focus-workspace "medias"
        ${pkgs.niri}/bin/niri msg action move-workspace-to-index 1

        ${pkgs.niri}/bin/niri msg action focus-workspace "devs"
        ${pkgs.niri}/bin/niri msg action move-workspace-to-index 2

        ${pkgs.niri}/bin/niri msg action focus-workspace "games"
        ${pkgs.niri}/bin/niri msg action move-workspace-to-index 3

        ${pkgs.niri}/bin/niri msg action focus-workspace "vms"
        ${pkgs.niri}/bin/niri msg action move-workspace-to-index 4

        # Secondary
        ${pkgs.niri}/bin/niri msg action focus-workspace "chats"
        ${pkgs.niri}/bin/niri msg action move-workspace-to-index 1

        ${pkgs.niri}/bin/niri msg action focus-workspace "tools"
        ${pkgs.niri}/bin/niri msg action move-workspace-to-index 2

        ${pkgs.niri}/bin/niri msg action focus-workspace "launchers"
        ${pkgs.niri}/bin/niri msg action move-workspace-to-index 3

        ${pkgs.niri}/bin/niri msg action focus-workspace "tv"
        ${pkgs.niri}/bin/niri msg action move-workspace-to-index 4

        # After
        ${pkgs.niri}/bin/niri msg action focus-workspace "chats"
        ${pkgs.niri}/bin/niri msg action focus-workspace "medias"

        echo "Niri workspaces ordered!" | logger -t niri-order
      '';
    };
  };
}
