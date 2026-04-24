{ inputs, ... }:
{
  flake-file.inputs = {
    nixcord.url = "github:FlameFlag/nixcord";
  };

  flake.modules.homeManager.programs-nixcord =
    {
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nixcord.homeModules.nixcord ];
      # programs.nixcord = {
      #   enable = true;
      #   discord.package = pkgs.discord;
      #   discord.equicord.enable = true;
      #   discord.vencord.enable = false;
      # };
      # TODO: replace in new file
      home.packages = with pkgs; [
        telegram-desktop # Telegram Desktop
      ];
    };
}
