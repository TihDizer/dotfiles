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

  environment.etc."udisks2/mount_options.conf".text = ''
    [defaults]
    ntfs_defaults=uid=%u,gid=%g,prealloc
    ntfs_allow=uid,gid,dmask,fmask,prealloc
  '';
}
