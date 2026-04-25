{ ... }:
{
  flake.modules.nixos.firewall =
    { ... }:
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
          checkReversePath = "loose";
        };
      };

      boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
    };
}
