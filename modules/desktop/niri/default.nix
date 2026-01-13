{
  config,
  pkgs,
  niri,
  ...
}:

{
  programs.niri = {
    enable = true;
    package = niri.packages.${pkgs.system}.niri-stable;
  };

  services.getty.autologinUser = "tihdizer";

  systemd.user.targets."niri-session".description = "Niri graphical session";

  systemd.user.services."niri-graphical-session" = {
    description = "Bridge niri session to graphical-session.target";
    after = [ "niri-session.target" ];
    wants = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.coreutils}/bin/true";
    };
    wantedBy = [ "niri-session.target" ];
  };

  environment.etc."wayland-sessions/niri-session.desktop".source = ./niri-session.desktop;

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };
}
