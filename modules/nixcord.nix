{ inputs, ... }:
{
  flake-file.inputs = {
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.nixcord =
    {
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
