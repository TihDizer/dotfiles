{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pkgs.sunshine
    pkgs.moonlight-qt
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
  };
}
