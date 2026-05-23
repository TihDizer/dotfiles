{ ... }:
{
  flake.modules.nixos.throne =
    { pkgs, ... }:
    {
      # VPN/Proxy (Nekoray fork)
      programs.throne = {
        enable = true;
        package = pkgs.throne;
        tunMode.enable = true;
        tunMode.setuid = true;
      };

      boot.kernelModules = [ "tun" ];
    };
}
