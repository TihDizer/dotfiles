{ ... }:
{
  flake.modules.nixos.usb =
    { pkgs, ... }:
    {
      # USB automount
      services.udisks2.enable = true;
      environment.systemPackages = with pkgs; [
        exfatprogs # exFAT
        ntfs3g     # NTFS
      ];
    };

  flake.modules.homeManager.usb =
      { ... }:
      {
        services.udiskie = {
          enable = true;
          automount = true;
          notify = true;
        };
      };
}
