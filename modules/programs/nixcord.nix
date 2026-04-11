{ inputs, ... }:
{
  flake-file.inputs = {
    nixcord.url = "github:FlameFlag/nixcord";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  flake.modules.homeManager.programs-nixcord =
    {
      pkgs,
      system,
      ...
    }:
    let
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
      };
    in
    {
      imports = [ inputs.nixcord.homeModules.nixcord ];
      programs.nixcord = {
        enable = true;
        discord.package = pkgs-stable.discord;
        discord.equicord.enable = true;
        discord.vencord.enable = false;
      };
      # TODO: replace in new file
      home.packages = with pkgs; [
        telegram-desktop # Telegram Desktop
      ];
    };
}
