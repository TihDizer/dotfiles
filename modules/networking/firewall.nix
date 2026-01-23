{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [
        53
        67
        68
      ];
      trustedInterfaces = [ "docker0" ];
      checkReversePath = "loose";
    };

    nat = {
      enable = true;
      externalInterface = "enp42s0";
      internalInterfaces = [ "docker0" ];
    };
  };

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}
