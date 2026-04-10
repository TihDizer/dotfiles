{ ... }:
{
  flake.modules.nixos.services-virtualization-docker =
    { ... }:
    {
      # Docker
      virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
      };
    };
}
