{ ... }:
{
  flake-file.inputs = { };

  flake.modules.nixos.copyq =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        copyq
        wl-clipboard
      ];
    };

  flake.modules.homeManager.copyq =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      rawColors =
        if config ? lib.stylix then
          config.lib.stylix.colors.withHashtag
        else
          {
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

      kittyExe = lib.getExe pkgs.kitty;
      nvimExe = lib.getExe pkgs.neovim;
    in
    {
      home.packages = with pkgs; [
        copyq
        wl-clipboard
      ];

      services.copyq = {
        enable = true;
        forceXWayland = false;
        systemdTarget = "graphical-session.target";
      };

      # Main Configuration File
      xdg.configFile."copyq/copyq.conf".text = ''
        [Options]
        native_menu_bar=false
        navigation_style=1
        hide_main_window=true
        hide_toolbar=true
        hide_toolbar_labels=true
        close_on_unfocus=true
        show_simple_items=false
        editor=${kittyExe} -e ${nvimExe} %1
        maxitems=500

        [Plugins]
        itemimage\enabled=true
        itemimage\max_image_width=600
        itemimage\max_image_height=360
      '';

      # Visual Theme Configuration
      xdg.configFile."copyq/copyq.theme".text = ''
        [Theme]
        bg=${rawColors.base00}
        fg=${rawColors.base05}
        alt_bg=${rawColors.base01}
        alt_fg=${rawColors.base06}
        sel_bg=${rawColors.base02}
        sel_fg=${rawColors.base05}
        border=${rawColors.base0D}
        notes_bg=${rawColors.base01}
        notes_fg=${rawColors.base04}
        num_bg=${rawColors.base00}
        num_fg=${rawColors.base0D}
        search_bg=${rawColors.base0A}
        search_fg=${rawColors.base00}
        style_main_window=true

        menu_bar_css="height: 0px; max-height: 0px; padding: 0px; border: none;"
        item_css="padding: 8px; width: 100%; max-width: 100%;"
        image_css="width: 100%; max-width: 100%; height: auto;"
      '';
    };
}
