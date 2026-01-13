{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    remmina # Remote desktop client
    zellij # terminal multiplexer
    helix # Rust code editor (like vim)
    obsidian # Markdown note app
    cosmic-files # Wayland file manager
    yazi # Terminal file manager
    google-chrome # Web browser
    mission-center # System monitor GUI
    # easyeffects # Audio effects tool
    # qpwgraph # PipeWire patchbay GUI
    pavucontrol # PulseAudio control GUI
    tray-tui # System tray TUI
    mousai # Music recognition tool
    rpm # RPM package manager
    dpkg # Debian package manager
    tabiew # Tabbed file viewer/manager
    bat # Cat clone with syntax highlighting
    atuin # Shell history search (atuin)
    lsd # Modern ls alternative
    cpufetch # CPU architecture viewer
    neofetch # System info display
    copyq # Clipboard manager
    gnome-keyring # GNOME keyring daemon
    # zoom-us # Zoom video conferencing
    tty-clock # Terminal clock screensaver
    clock-rs # Terminal clock (Rust)
    clipmenu # Wayland clipboard manager (menu)
    poppler # PDF rendering library
    fd # Fast find alternative
    file # File type detector
    jq # JSON processor
    ripgrep # Fast grep (rg)
    fzf # Fuzzy finder
    zoxide # Smart cd (z)
    resvg # SVG rasterizer
    imagemagick # Image manipulation
    wl-clipboard # Wayland clipboard tools
    jellyfin-ffmpeg # Jellyfin FFmpeg build
    bluetuith # Bluetooth TUI manager
    mesa-demos # glxinfo, glxgears
    vulkan-tools # vulkaninfo
  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      # cudaSupport = true;   # NVIDIA
      rocmSupport = true; # AMD
    };
  };
}
