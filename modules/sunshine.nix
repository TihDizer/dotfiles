{ ... }:
{
  flake.modules.nixos.sunshine =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        moonlight-qt # Client
      ];

      systemd.user.services.sunshine = {
        serviceConfig = {
          TimeoutStopSec = "5s";
          ExecStartPre = "-${pkgs.procps}/bin/pkill -u %u -x sunshine";
        };
      };

      services.sunshine = {
        enable = true;
        openFirewall = true;
        capSysAdmin = true;
        autoStart = true;

        settings = {
          capture = "kms";
          output_name = 0;
          adapter_name = "/dev/dri/card1";
        };

        applications = {
          apps = [
            {
              name = "Primary Monitor";
            }
            {
              name = "Secondary Monitor";
            }
            {
              name = "TV";
            }
          ];
        };
      };
    };
}
