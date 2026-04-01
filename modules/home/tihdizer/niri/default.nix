{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) getExe;
in
{
  imports = [
    ./binds.nix
    ./env.nix
    ./input.nix
    ./outputs.nix
    ./settings.nix
    ./startup.nix
    ./windowrules.nix
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

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config = {
      common.default = [ "gnome" ];
    };
    xdgOpenUsePortal = true;
  };

  #= Used Packages
  home.packages = with pkgs; [
    alacritty # Terminal
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
    fuzzel # Wayland launcher (rofi-wayland аналог)
    swaylock-effects # Screen locker с эффектами
    nautilus # File manager (GNOME)
    # gnome-keyring # GNOME keyring daemon
    # copyq # Clipboard manager
    # clipmenu # Wayland clipboard manager (menu)
    # wl-clipboard # Wayland clipboard tools
  ];
}
