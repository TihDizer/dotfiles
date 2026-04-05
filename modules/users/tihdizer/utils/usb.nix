{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-utils-usb =
    { ... }:
    {
      services.udiskie = {
        enable = true;
        automount = true;
        notify = true;
      };
    };
}
