{ ... }:
{
  flake.modules.nixos.services-virtualization-docker =
    { ... }:
    {
      virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
      };
    };
}
