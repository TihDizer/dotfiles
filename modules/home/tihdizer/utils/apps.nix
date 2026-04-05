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
    jellyfin-ffmpeg # Jellyfin FFmpeg build
    qbittorrent # BitTorrent client
    mpv # Video player
    postman
    codex
  ];
}
