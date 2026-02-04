{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    remmina # Remote desktop client
    obsidian # Markdown note app
    cosmic-files # Wayland file manager
    mission-center # System monitor GUI
    mousai # Music recognition tool

    jellyfin-ffmpeg # Jellyfin FFmpeg build
    bluetuith # Bluetooth TUI manager
  ];
}
