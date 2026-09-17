{ inputs, ... }:
{
  flake-file.inputs = {
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.yazi =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      yazi-wrapper = pkgs.writeShellScriptBin "yazi-wrapper" ''
        set -e

        multiple="$1"
        directory="$2"
        save="$3"
        path="$4"
        out="$5"

        if [ "$save" = "1" ]; then
          set -- --chooser-file="$out" "$path"
        elif [ "$directory" = "1" ]; then
          set -- --chooser-file="$out" --cwd-file="$out" "$path"
        else
          set -- --chooser-file="$out" "$path"
        fi

        exec ${lib.getExe pkgs.kitty} \
          --class=file_chooser \
          -e ${lib.getExe config.programs.yazi.package} \
          "$@"
      '';

      yazi-floating = pkgs.writeShellScriptBin "yazi-floating" ''
        exec ${lib.getExe pkgs.kitty} \
          --class=yazi-floating \
          -e ${lib.getExe config.programs.yazi.package} \
          "$@"
      '';
    in
    {
      programs.yazi = {
        enable = true;
        package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;

        plugins = {
          mount = pkgs.yaziPlugins.mount;
          smart-enter = pkgs.yaziPlugins.smart-enter;
          ouch = pkgs.yaziPlugins.ouch;
          piper = pkgs.yaziPlugins.piper;
        };

        settings = {
          plugin = {
            prepend_previewers = [
              {
                url = "*.html";
                run = ''piper -- w3m -dump -T text/html -cols "$w" "$1"'';
              }
              {
                url = "*.htm";
                run = ''piper -- w3m -dump -T text/html -cols "$w" "$1"'';
              }
              {
                mime = "text/html";
                run = ''piper -- w3m -dump -T text/html -cols "$w" "$1"'';
              }
            ];
          };
        };

        keymap = {
          mgr.prepend_keymap = [
            {
              on = "l";
              run = "plugin smart-enter";
              desc = "Enter the child directory, or open the file";
            }
            {
              on = "M";
              run = "plugin mount";
              desc = "Mount device / disk";
            }
            {
              on = "y";
              run = [
                ''shell -- for path in %s; do echo "file://$path"; done | wl-copy -t text/uri-list''
                "yank"
              ];
            }
            {
              on = "x";
              run = [
                ''shell -- for path in %s; do echo "file://$path"; done | wl-copy -t text/uri-list''
                "yank --cut"
              ];
            }
            {
              on = "<C-p>";
              run = ''shell -- wl-paste -t text/uri-list 2>/dev/null | tr -d "\r" | while IFS= read -r uri; do [ -z "$uri" ] && continue; if [[ "$uri" =~ ^file://(.*) ]]; then path="''${BASH_REMATCH[1]}"; printf -v path '%b' "''${path//%/\\x}"; else path="$uri"; fi; [ -e "$path" ] && cp -r -- "$path" .; done'';
            }
          ];
        };
      };

      home.sessionVariables = {
        GTK_USE_PORTAL = "1";
        QT_QPA_PLATFORMTHEME = lib.mkForce "xdgdesktopportal";
        TDESKTOP_USE_GTK_FILE_DIALOG = "1";
      };

      xdg.desktopEntries.yazi = {
        name = "Yazi";
        genericName = "File Manager";
        comment = "Terminal file manager";

        exec =
          "${yazi-floating}/bin/yazi-floating %U";

        icon = "yazi";

        terminal = false;
        type = "Application";

        categories = [
          "System"
          "FileManager"
          "FileTools"
        ];

        mimeType = [
          "inode/directory"
          "application/x-directory"
        ];
      };

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "yazi.desktop" ];
          "application/x-directory" = [ "yazi.desktop" ];
        };
      };

      xdg.portal = {
        extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
        config = {
          common = {
            "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
          };
          niri = {
            "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
          };
        };
      };

      xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
        text = ''
          [filechooser]
          cmd=${yazi-wrapper}/bin/yazi-wrapper
          default_dir=$HOME
        '';
      };

      home.packages = with pkgs; [
        trash-cli # Trash manager
        ouch # Painless compression and decompression in the terminal
        w3m # Text-based web browser / HTML renderer
        util-linux # Provides lsblk, eject for mount plugin
        ffmpeg # Multimedia framework
        poppler # PDF rendering library
        fd # Fast find alternative
        file # File type detector
        jq # JSON processor
        ripgrep # Fast grep (rg)
        fzf # Fuzzy finder
        zoxide # Smart cd (z)
        resvg # SVG rasterizer
        imagemagick # Image manipulation
        bat # Cat clone with syntax highlighting
        lsd # Modern ls alternative
        ripdrag # Drag and drop utility
        wl-clipboard-rs # Wayland clipboard
      ];
    };
}
