{ ... }:
{
  flake.modules.nixos.sunshine =
    { pkgs, config, ... }:
    {
      environment.systemPackages = with pkgs; [
        moonlight-qt # Client
      ];

      services.sunshine = {
        enable = true;
        openFirewall = true;
        capSysAdmin = true;
        autoStart = false;

        settings = {
          capture = "kms";
          adapter_name = "/dev/dri/card1";

          https_port = 47990;
          http_port = 47989;
        };

        applications = {
          apps = [
            {
              name = "Desktop";
            }
          ];
        };
      };

      systemd.services.sunshine = {
        description = "Sunshine self-hosted game stream host (System Service)";
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];

        serviceConfig = {
          Type = "simple";
          ExecStart = "${config.services.sunshine.package}/bin/sunshine ${config.services.sunshine.settings.file_apps}";
          Restart = "always";
          RestartSec = "3s";
          AmbientCapabilities = [ "CAP_SYS_ADMIN" ];
          CapabilityBoundingSet = [ "CAP_SYS_ADMIN" ];
          User = "root";
        };
      };
    };
}
