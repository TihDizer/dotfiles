{ inputs, ... }:
{
  flake-file.inputs = {
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };

  flake.modules.nixos.services-networking-zapret =
    { ... }:
    {
      imports = [
        inputs.zapret-discord-youtube.nixosModules.default
      ];

      services.zapret-discord-youtube = {
        enable = true;
        configName = "general(ALT)";
      };
    };
}
