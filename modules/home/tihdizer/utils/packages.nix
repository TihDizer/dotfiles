{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    tray-tui # System tray TUI
    piper # Logitech control panel
    libratbag # Logitech ratbag daemon
    rpm # RPM package manager
    dpkg # Debian package manager
    cpufetch # CPU architecture viewer
    neofetch # System info display

    # zoom-us # Zoom video conferencing
    tty-clock # Terminal clock screensaver
    clock-rs # Terminal clock (Rust)

    jellyfin-ffmpeg # Jellyfin FFmpeg build

    bluetuith # Bluetooth TUI manager

  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      # cudaSupport = true;   # NVIDIA
      rocmSupport = true; # AMD
    };
  };
}
