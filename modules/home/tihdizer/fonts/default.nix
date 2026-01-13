{ pkgs, config, ... }:

{
  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  home.packages = with pkgs; [
    # Core
    corefonts
    fira

    # Nerd Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack

    # Unicode
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
