{ ... }:
{
  flake.modules.nixos.sunshine =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        moonlight-qt # Client
      ];

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
