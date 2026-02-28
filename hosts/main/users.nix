{
  pkgs,
  ...
}:

{
  users.users.tihdizer = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "TihDizer";
    extraGroups = [
      "wheel"
      "libvirtd"
      "kvm"
      "docker"
      "networkmanager"
      "audio"
      "video"
      "input"
      "plugdev"
    ];
  };
}
