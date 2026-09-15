{ ... }:
{
  flake.modules.nixos.system-bootloader =
    { ... }:
    {
      # Boot
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.timeout = 0;

      boot.consoleLogLevel = 3;
      boot.initrd.verbose = false;
    };
}
