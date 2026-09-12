{ ... }:
{
  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      hardware.bluetooth.settings = {
        General = {
          FastConnectable = true;
          JustWorksRepairing = "always";
          PairableTimeout = 0;
          Experimental = true;
          MultiProfile = "multiple";
        };
        Policy = {
          AutoEnable = true;
          ReconnectAttempts = 7;
          ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
        };
      };

      hardware.bluetooth.input = {
        General = {
          ClassicBondedOnly = false;
          IdleTimeout = 0;
          UserspaceHID = true;
        };
      };

      boot.kernelModules = [ "uhid" ];

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

