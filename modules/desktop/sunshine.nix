{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pkgs.sunshine
    pkgs.moonlight-qt # for testing purposes.
  ];

  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
  networking.firewall = {
    allowedTCPPorts = [ 47984 47989 47990 48010 ];
    allowedUDPPortRanges = [
      { from = 47998; to = 48000; }
      #{ from = 8000; to = 8010; }
    ];
}
