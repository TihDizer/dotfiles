{
  config,
  niri,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) getExe;
in
{
  imports = [
    # niri.homeModules.niri
    ./binds.nix
    ./env.nix
    ./input.nix
    ./outputs.nix
    ./settings.nix
    ./startup.nix
    ./windowrules.nix
    ./kanshi.nix
  ];
  # nixpkgs.overlays = [ niri.overlays.niri ];

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
    ];
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
    xorg.libxcb
    xorg.xprop
    xorg.xkbcomp

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
