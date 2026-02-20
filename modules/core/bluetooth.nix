{
  pkgs,
  ...
}:

{
  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.kernelParams = [ "btusb.enable_autosuspend=n" ];

  environment.systemPackages = with pkgs; [
    bluetuith
    # bluetui
  ];
}
