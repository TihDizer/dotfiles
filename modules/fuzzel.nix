{ ... }:
{
  flake-file.inputs = { };

  flake.modules.nixos.fuzzel =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.fuzzel ];
    };

  flake.modules.homeManager.fuzzel =
    {
      config,
      options,
      lib,
      pkgs,
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

      colors = builtins.mapAttrs (_: val: lib.removePrefix "#" val) rawColors;

      font =
        if config ? stylix.fonts then
          "${config.stylix.fonts.sansSerif.name}:size=${toString (config.stylix.fonts.sizes.popups or 12)}"
        else
          "DejaVu Sans:size=12";

      cliphist-fuzzel = pkgs.writeShellScriptBin "cliphist-fuzzel" ''
        item="$(${pkgs.cliphist}/bin/cliphist list | ${lib.getExe config.programs.fuzzel.package} --dmenu --prompt="󰅌  " --lines=15 --width=60)"
        status=$?

        if [ $status -eq 0 ] && [ -n "$item" ]; then
          printf '%s' "$item" | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy
        elif [ $status -eq 10 ] && [ -n "$item" ]; then
          printf '%s' "$item" | ${pkgs.cliphist}/bin/cliphist delete
        fi
      '';
    in
    {
      stylix = lib.mkIf (options ? stylix) {
        targets.fuzzel.enable = false;
      };

      home.packages = [ cliphist-fuzzel ];

      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            font = font;
            prompt = "\"󰍉  \"";
            terminal = "${lib.getExe pkgs.kitty} -e";
            icon-theme = "Papirus-Dark";
            icons-enabled = "yes";
            show-actions = "yes";
            lines = 15;
            width = 60;
            horizontal-pad = 24;
            vertical-pad = 16;
            inner-pad = 8;
            line-height = 24;
            fields = "filename,name,generic";
            layer = "overlay";
            exit-on-keyboard-focus-loss = "yes";
          };

          border = {
            width = 2;
            radius = 12;
            selection-radius = 8;
          };

          colors = {
            background = "${colors.base00}f2";
            text = "${colors.base05}ff";
            prompt = "${colors.base0D}ff";
            placeholder = "${colors.base03}ff";
            input = "${colors.base05}ff";
            match = "${colors.base0A}ff";
            selection = "${colors.base02}ff";
            selection-text = "${colors.base05}ff";
            selection-match = "${colors.base0A}ff";
            counter = "${colors.base03}ff";
            border = "${colors.base0D}ff";
          };

          key-bindings = {
            expunge = "Shift+Delete Mod1+Delete";
          };
        };
      };
    };
}
