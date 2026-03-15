{
  pkgs,
  ...
}:

{
  # USB automount
  services.udisks2.enable = true;
  services.gvfs.enable = true;
}
