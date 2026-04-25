{ ... }:
{
  flake.modules.nixos.throne =
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
