{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Communication
    telegram-desktop # Telegram Desktop
    vesktop # Discord (Wayland-native для niri)

    # Calls/Meetings
    discord-canary # Discord beta
    # zoom-us # Zoom video conferencing
  ];
}
