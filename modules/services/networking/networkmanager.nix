{ ... }:
{
  flake.modules.nixos.networkmanager =
    { pkgs, ... }:
    {
      networking.networkmanager.enable = true;

      environment.systemPackages = with pkgs; [
        iptables # Firewall rules
        iproute2 # Network routing
        inetutils # Network utils
        mtr # Traceroute tool
        tcpdump # Packet capture
        nmap # Port scanner
        bind # DNS tools
        pciutils # Hardware info
        networkmanagerapplet # NM tray
      ];
    };
}
