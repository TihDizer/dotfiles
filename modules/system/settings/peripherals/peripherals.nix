{ ... }:
{
  flake.modules.nixos.system-peripherals =
    { pkgs, ... }:
    {
      services.hardware.openrgb.enable = true;

      environment.systemPackages = with pkgs; [
        dfu-util
      ];

      boot.kernelModules = [
        "hid-generic"
        "usbhid"
      ];

      services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", GROUP="users"
      '';
    };
}
