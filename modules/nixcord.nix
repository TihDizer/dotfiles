{ inputs, ... }:
{
  flake-file.inputs = {
    nixcord.url = "github:FlameFlag/nixcord";
  };

  flake.modules.homeManager.nixcord =
    {
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nixcord.homeModules.nixcord ];
      programs.nixcord = {
        enable = true;
        discord.equicord.enable = true;
        discord.vencord.enable = false;
      };
    };
}
