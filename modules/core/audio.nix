{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
