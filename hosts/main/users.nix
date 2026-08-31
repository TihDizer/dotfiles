{ ... }:
{
  flake.modules.nixos.host-main-users =
    { pkgs, ... }:
    {
      users.users.tihdizer = {
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "TihDizer";
        extraGroups = [
          # TODO: move in modules
          "wheel"
          "libvirtd"
          "kvm"
          "plugdev"
          "docker"
          "networkmanager"
          "audio"
          "video"
          "input"
        ];
      };
    };
}
