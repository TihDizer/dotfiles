{
  inputs,
  ...
}:
{
  flake.modules.homeManager.tihdizer-utils =
    { ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        icons
        packages
        usb
      ];
    };
}
