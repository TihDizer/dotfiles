{ inputs, ... }:
{
  flake.modules.homeManager.tihdizer-niri =
    { pkgs, lib, ... }:
    let
      inherit (lib) getExe;
    in
    {
      imports = with inputs.self.modules.homeManager; [
        tihdizer-niri-binds
        tihdizer-niri-env
        tihdizer-niri-input
        tihdizer-niri-outputs
        tihdizer-niri-settings
        tihdizer-niri-startup
        tihdizer-niri-windowrules
      ];

      #= Setup Niri
      programs.niri = {
        enable = true;
        package = pkgs.niri;
        settings.xwayland-satellite = {
          enable = true;
          path = getExe pkgs.xwayland-satellite;
        };
      };

      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = {
          screenshots = true;
          clock = true;
          indicator = true;
          indicator-radius = 100;
          indicator-thickness = 7;
          effect-blur = "7x5";
          effect-vignette = "0.5:0.5";
          fade-in = 0.2;
        };
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
        config = {
          common = {
            default = [
              "gnome"
              "gtk"
            ];
          };
          niri = {
            default = [
              "gnome"
              "gtk"
            ];
            "org.freedesktop.impl.portal.Screencast" = [ "gnome" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
          };
        };
        xdgOpenUsePortal = true;
      };

      #= Used Packages
      home.packages = with pkgs; [
        # Wayland Output Mirror Client
        wl-mirror
        # Prevents swayidle from sleeping while any application is outputting or receiving audio.
        sway-audio-idle-inhibit
        gnome-keyring
        # Clipboard-specific
        wl-clipboard-rs
        cliphist
        # Image Viewer
        imv
        # XWayland/Wayland
        wlr-randr
        wayland-utils
        xcb-util-cursor
        libxcb
        xprop
        xkbcomp
        # Wayland desktop (niri)
        wlogout
      ];
    };
}
