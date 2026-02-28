{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    remmina # Remote desktop client
    obsidian # Markdown note app
    cosmic-files # Wayland file manager
    mission-center # System monitor GUI
    citrix_workspace # Citrix Workspace
    jellyfin-ffmpeg # Jellyfin FFmpeg build
    qbittorrent # BitTorrent client
  ];
}
