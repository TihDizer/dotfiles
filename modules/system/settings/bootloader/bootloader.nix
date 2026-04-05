{ ... }:
{
  flake.modules.nixos.system-bootloader =
    { ... }:
    {
      # Boot
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
    };
}
