{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Bluetooth
  hardware.bluetooth.enable = true;
  systemd.user.services.obex = {
    enable = true;
    description = "Bluetooth OBEX daemon";
    serviceConfig.ExecStart = "${pkgs.bluez}/libexec/bluetooth/obexd --root=%h/Downloads --auto-accept";
  };
}
