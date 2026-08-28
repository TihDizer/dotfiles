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
          adapter_name = "/dev/dri/card1";

          https_port = 47990;
          http_port = 47989;
        };

        applications = {
          apps = [
            {
              name = "Main Monitor (DP-3)";
              output_name = 0;
            }
            {
              name = "Secondary Monitor (DP-5)";
              output_name = 1;
            }
            {
              name = "TV (HDMI-A-1)";
              output_name = 2;
            }
          ];
        };
      };
    };
}
