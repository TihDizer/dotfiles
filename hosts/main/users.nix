{ config, pkgs, ... }:

{
  users.users.tihdizer = {
    isNormalUser = true;
    description = "TihDizer";
    extraGroups = [
      "wheel"
      "libvirtd"
      "docker"
      "networkmanager"
      "audio"
      "video"
      "input"
      "plugdev"
    ];
  };
}
