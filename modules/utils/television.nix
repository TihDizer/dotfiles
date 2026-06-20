{ ... }:
{
  flake.modules.homeManager.television =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        television
        ripgrep
        fd
        gtk3
        chafa
        file
      ];

      home.file.".config/television/cable/apps.toml".text = ''
        [metadata]
        name = "apps"
        description = "Applications launcher"

        [source]
        command = 'printf "%s\n%s\n%s\n%s\n" "$XDG_DATA_DIRS" "$HOME/.local/share" "$HOME/.local/share/flatpak/exports/share" "/var/lib/flatpak/exports/share" | tr ":" "\n" | xargs -d "\n" -I {} find {}/applications -name "*.desktop" 2>/dev/null | xargs -d "\n" -I {} basename {} .desktop | sort -u'

        [keybindings]
        enter = "actions:launch"

        [actions.launch]
        command = "XDG_DATA_DIRS=\"$HOME/.local/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS\" nohup gtk-launch {} > ~/.cache/television-launch.log 2>&1 &"
        mode = "execute"
      '';

      home.file.".config/television/cable/clip.toml".text = ''
        [metadata]
        name = "clip"
        description = "Clipboard history manager (cliphist)"

        [source]
        command = "cliphist list"

        [preview]
        command = "sh -c 'sz=''$(stty size </dev/tty 2>/dev/null || echo \"24 80\"); w=''$((''${sz#* } * 5 / 10)); h=''$((''${sz% *} - 4)); tmp=''$(mktemp); cliphist decode ''$1 > ''$tmp 2>/dev/null; if file --mime-type ''$tmp | grep -q \"image/\"; then chafa -f symbols --probe off --size=\"''${w}x''${h}\" ''$tmp 2>/dev/null; else cat ''$tmp; fi; rm -f ''$tmp' -- {}"

        [keybindings]
        enter = "actions:copy"

        [actions.copy]
        command = "sh -c 'cliphist decode ''$1 | wl-copy' -- {}"
        mode = "execute"
      '';
    };
}
