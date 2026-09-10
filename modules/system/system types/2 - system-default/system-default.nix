{ inputs, ... }:
{
  flake-file.inputs = {
  };

  flake.modules.nixos.system-default =
    { ... }:
    {
      imports = with inputs.self.modules.nixos; [
        system-audio
        bluetooth
        system-bootloader
        system-packages
        amd
        usb
        system-stylix
        system-peripherals
      ];
    };
}
