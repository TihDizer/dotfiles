{ ... }:
{
  flake.modules.homeManager.tihdizer-usb =
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
