{
  config,
  lib,
  pkgs,
  ...
}:

{
  # USB automount
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  boot.blacklistedKernelModules = [ "ntfs3" ];
}
