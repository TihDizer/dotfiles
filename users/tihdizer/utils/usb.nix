{ ... }:
{
  flake.modules.homeManager.tihdizer-utils-usb =
    { ... }:
    {
      # TODO: move in modules
      services.udiskie = {
        enable = true;
        automount = true;
        notify = true;
      };
    };
}
