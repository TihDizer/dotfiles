{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Communication
    telegram-desktop # Telegram Desktop

    # Calls/Meetings
    discord-canary # Discord beta
    # zoom-us # Zoom video conferencing
  ];
}
