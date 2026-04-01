{
  nixcord,
  pkgs,
  ...
}:

{
  imports = [ nixcord.homeModules.nixcord ];
  programs.nixcord = {
    enable = true;
    discord.equicord.enable = true;
    discord.vencord.enable = false;
    config = {
      useQuickCss = true;
      frameless = true;
    };
  };

  home.packages = with pkgs; [
    telegram-desktop # Telegram Desktop
  ];
}
