{ config, pkgs, ... }:

{
  # Docker
  virtualisation.docker = {
    enable = true;
    # Use a mirror if docker.io is unreachable
    daemon.settings = {
      registry-mirrors = [ "https://mirror.gcr.io" ];
    };
    # If you have a local proxy (e.g., v2ray/clash), route Docker through it
    # proxy = {
    #   httpProxy = "http://127.0.0.1:20171";
    #   httpsProxy = "http://127.0.0.1:20171";
    # };
  };
}
