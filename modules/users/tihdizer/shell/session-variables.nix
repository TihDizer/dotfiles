{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-shell-session-variables =
    { ... }:
    {
      home.sessionVariables = {
        LIBVIRT_DEFAULT_URI = "qemu:///system";
      };
    };
}
