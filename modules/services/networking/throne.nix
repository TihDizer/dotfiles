{ ... }:
{
  flake.modules.nixos.services-networking-throne =
    { ... }:
    {
      # VPN/Proxy (Nekoray fork)
      programs.throne = {
        enable = true;
        tunMode.enable = true;
        tunMode.setuid = true;
      };

      boot.kernelModules = [ "tun" ];
    };
}
