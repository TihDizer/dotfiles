{
  inputs,
  ...
}:
{
  flake.modules.homeManager.tihdizer-utils =
    { ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        tihdizer-icons
        tihdizer-packages
        tihdizer-usb
      ];
    };
}
