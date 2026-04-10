{ ... }:
{
  flake.modules.nixos.system-bluetooth =
    { pkgs, ... }:
    {
      # Bluetooth
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;

      environment.systemPackages = with pkgs; [
        bluetuith
      ];

      services.udev.extraRules = ''
        ACTION=="change", SUBSYSTEM=="bluetooth", ATTR{authorized}="1"
      '';

      boot.kernelParams = [
        "btusb.enable_autosuspend=n"
        "usbcore.autosuspend=-1"
      ];
    };
}
