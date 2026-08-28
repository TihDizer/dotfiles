{ inputs, ... }:
{
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.system-stylix =
    { config, pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = {
        enable = true;
        # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
        base16Scheme = {
          base00 = "#272e33";
          base01 = "#2e383c";
          base02 = "#414b50";
          base03 = "#859289";
          base04 = "#9da9a0";
          base05 = "#d3c6aa";
          base06 = "#edeada";
          base07 = "#fffbef";
          base08 = "#e67e80";
          base09 = "#e69875";
          base0A = "#dbbc7f";
          base0B = "#a7c080";
          base0C = "#83c092";
          base0D = "#7fbbb3";
          base0E = "#d699b6";
          base0F = "#9da9a0";
        };
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font Mono";
          };
          sansSerif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Sans";
          };
          serif = config.stylix.fonts.sansSerif;
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
          sizes = {
            applications = 12;
            terminal = 12;
            desktop = 10;
            popups = 12;
          };
        };
        targets.kmscon.enable = false;
        polarity = "dark";
        # image = ../../assets/;
      };
    };
}
