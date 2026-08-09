{ inputs, ... }:
{
  flake-file.inputs = {
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.system-default =
    { ... }:
    {
      nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

      imports = with inputs.self.modules.nixos; [
        system-audio
        system-bluetooth
        system-bootloader
        system-packages
        amd
        system-usb
        system-stylix
        system-peripherals
      ];
    };
}
