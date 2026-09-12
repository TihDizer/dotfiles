{ ... }:
{
  flake.modules.nixos.host-main-users =
    { pkgs, lib, ... }:
    {
      users.mutableUsers = lib.mkDefault true;

      users.users.tihdizer = {
        isNormalUser = true;
        initialPassword = "nixos";
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

      users.users.root = {
        initialPassword = "nixos";
      };
    };
}
