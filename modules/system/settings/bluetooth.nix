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
          Enable = "Source,Sink,Media,Socket";
        };
      };

      hardware.enableAllFirmware = true;

      environment.systemPackages = with pkgs; [
        bluetuith
        usbutils
      ];
    };
}
