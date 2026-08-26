{ ... }:
{
  flake.modules.nixos.ssh =
    { ... }:
    {
      services.openssh = {
        enable = true;
        ports = [ 22 ];
      };
    };

  flake.modules.homeManager.ssh =
    { ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
      };
    };
}
