{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Communication
    telegram-desktop # Telegram Desktop

    # Calls/Meetings
    discord-canary # Discord beta
    discord
    vesktop
    # zoom-us # Zoom video conferencing
  ];
}
