{ ... }:
{
  flake.modules.homeManager.tihdizer-utils-usb =
    { ... }:
    {
      services.udiskie = {
        enable = true;
        automount = true;
        notify = true;
      };
    };
}
