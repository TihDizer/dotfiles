{
  config,
  lib,
  pkgs,
  niri,
  ...
}:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [
      53
      67
      68
    ];
    checkReversePath = "loose";
  };
}
