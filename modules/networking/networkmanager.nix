{ ... }:
{
  flake.modules.nixos.networkmanager =
    { pkgs, ... }:
    {
      networking.networkmanager = {
        enable = true;
        dns = "default";
      };

      networking.enableIPv6 = false;

      networking.nameservers = [
        "77.88.8.8"
        "8.8.8.8"
      ];

      environment.systemPackages = with pkgs; [
        iptables # Firewall rules
        iproute2 # Network routing
        inetutils # Network utils
        mtr # Traceroute tool
        tcpdump # Packet capture
        nmap # Port scanner
        bind # DNS tools
        pciutils # Hardware info
        ethtool # Ethernet device control (WoL, etc.)
        networkmanagerapplet # NM tray
      ];
    };
}
