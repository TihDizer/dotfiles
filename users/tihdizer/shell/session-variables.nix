{ ... }:
{
  flake.modules.homeManager.tihdizer-session-variables =
    { ... }:
    {
      # TODO: move in virtualisation
      home.sessionVariables = {
        LIBVIRT_DEFAULT_URI = "qemu:///system";
      };
    };
}
