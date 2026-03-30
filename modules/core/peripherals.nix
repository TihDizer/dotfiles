{
  pkgs,
  ...
}:

{
  # Logitech G102
  services.ratbagd.enable = true;

  boot.kernelModules = [
    "hid-generic"
    "usbhid"
  ];

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", GROUP="users"
  '';
}
