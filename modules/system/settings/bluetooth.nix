{ ... }:
{
  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      hardware.bluetooth.settings = {
        General = {
          JustWorksRepairing = "always";
          PairableTimeout = 0;
        };
        Policy = {
          AutoEnable = true;
        };
      };

      hardware.enableAllFirmware = true;

      environment.systemPackages = with pkgs; [
        bluetuith
        usbutils
      ];
    };

  flake.modules.homeManager.bluetooth =
    { ... }:
    {
      xdg.configFile."bluetuith/bluetuith.conf".text = ''
        {
          keybindings: {
            NavigateLeft: h
            NavigateDown: j
            NavigateUp: k
            NavigateRight: l
            FilebrowserDirBack: h
            FilebrowserDirForward: l
          }
        }
      '';
    };
}

