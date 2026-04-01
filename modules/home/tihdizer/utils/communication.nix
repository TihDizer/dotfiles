{
  nixcord,
  pkgs,
  ...
}:

{
  # imports = [ nixcord.homeModules.nixcord ];
  # programs.nixcord = {
  #   enable = true;
  #   package = pkgs.discord;
  #   discord.equicord.enable = true;
  #   discord.vencord.enable = false;
  # };

  home.packages = with pkgs; [
    telegram-desktop # Telegram Desktop
    discord
  ];
}
