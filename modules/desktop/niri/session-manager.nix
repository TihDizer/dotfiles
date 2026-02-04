{
  config,
  pkgs,
  lib,
  ...
}:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  niri-session = "${pkgs.niri}/bin/niri-session";
in
{
  #|==< UWSM >==|#
  programs.uwsm = {
    enable = true;
    waylandCompositors.niri = {
      prettyName = "Niri";
      comment = "Scrollable-tiling Wayland compositor";
      binPath = niri-session;
    };
  };
  #|==< TuiGreet >==|#
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = lib.mkForce 7;
      default_session = {
        command = "${tuigreet} --time --remember --asterisks --container-padding 2 --no-xsession-wrapper";
        user = "greeter";
      };
    };
  };
}
