{
  config,
  pkgs,
  zapret-discord-youtube,
  ...
}:

{
  imports = [
    zapret-discord-youtube.nixosModules.default
  ];

  services.zapret-discord-youtube = {
    enable = true;
    config = "general(ALT)";
  };
}
