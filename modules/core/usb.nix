{
  config,
  lib,
  pkgs,
  ...
}:

{
  # USB automount
  services.udisks2.enable = true;
}
