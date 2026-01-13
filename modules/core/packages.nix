{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # CLI essentials
    vim # Text editor
    wget # HTTP downloader
    git # Version control

    pciutils # Hardware info

    # System monitoring
    tree # Directory tree viewer
    atop # Advanced process monitor
    htop # Interactive process viewer

    # Hardware/VM
    lm_sensors # Hardware monitoring
  ];
}
