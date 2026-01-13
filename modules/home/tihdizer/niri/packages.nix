{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Wayland desktop (niri)
    alacritty # Terminal
    fuzzel # Wayland launcher (rofi-wayland аналог)
    swaylock-effects # Screen locker с эффектами
    nautilus # File manager (GNOME)
    xwayland-satellite # XWayland bridge для legacy X11 apps
    gnome-keyring # GNOME keyring daemon
    copyq # Clipboard manager
    clipmenu # Wayland clipboard manager (menu)
    wl-clipboard # Wayland clipboard tools
  ];
}
