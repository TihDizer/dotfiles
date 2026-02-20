{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    moonlight-qt # Client
  ];

  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = true;

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
}
