{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./bootloader.nix
    ./packages.nix
    ./amd.nix
    ./usb.nix
  ];
}
