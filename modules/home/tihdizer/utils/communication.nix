{ pkgs, ... }:

{
  programs.nixcord = {
    enable = true;
    discord.equicord.enable = true;
    config = {
      useQuickCss = true;
      frameless = true;
      plugins = {
        hideAttachments.enable = true;
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
        };
      };
    };
  };

  home.packages = with pkgs; [
    telegram-desktop # Telegram Desktop
  ];
}
