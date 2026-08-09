{ ... }:
{
  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      hardware.bluetooth.settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };

      hardware.enableAllFirmware = true;

      environment.systemPackages = with pkgs; [
        bluetuith
        usbutils
      ];

      boot.kernelParams = [
        "btusb.enable_autosuspend=n"
        "usbcore.autosuspend=-1"
      ];

      boot.extraModprobeConfig = ''
        options btusb enable_autosuspend=N reset=1
      '';

      services.udev.extraRules = ''
        ACTION=="change", SUBSYSTEM=="bluetooth", ATTR{authorized}="1"
      '';
    };
}
