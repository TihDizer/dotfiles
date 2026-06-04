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
      ];
      home.file.".config/television/cable/apps.toml".text = ''
        [metadata]
        name = "apps"
        description = "Applications launcher"

        [source]
        command = 'printf "%s\n%s\n%s\n%s\n" "$XDG_DATA_DIRS" "$HOME/.local/share" "$HOME/.local/share/flatpak/exports/share" "/var/lib/flatpak/exports/share" | tr ":" "\n" | xargs -d "\n" -I {} find {}/applications -name "*.desktop" 2>/dev/null | xargs -d "\n" -I {} basename {} .desktop | sort -u'

        [preview]
        command = 'printf "%s\n%s\n%s\n%s\n" "$XDG_DATA_DIRS" "$HOME/.local/share" "$HOME/.local/share/flatpak/exports/share" "/var/lib/flatpak/exports/share" | tr ":" "\n" | xargs -d "\n" -I {} find {}/applications -name "{}.desktop" 2>/dev/null | head -n1 | xargs -d "\n" -I {} grep -E "^(Name|Comment|Exec)=" 2>/dev/null'

        [keybindings]
        enter = "actions:launch"

        [actions.launch]
        command = "XDG_DATA_DIRS=\"$HOME/.local/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS\" nohup gtk-launch '{}' > ~/.cache/television-launch.log 2>&1 &"
        mode = "execute"
      '';

      home.file.".config/television/cable/clipboard.toml".text = ''
        [metadata]
        name = "clipboard"
        description = "Clipboard history manager (cliphist)"

        [source]
        command = "sh -c 'res=$(cliphist list 2>/dev/null); if [ -z \"$res\" ]; then echo \"[Clipboard is empty]\"; else echo \"$res\"; fi'"

        [preview]
        command = "sh -c 'tmp=$(mktemp); echo \"{}\" | cliphist decode > \"$tmp\" 2>/dev/null; if file --mime-type \"$tmp\" | grep -q \"image/\"; then chafa --size=60x30 \"$tmp\" 2>/dev/null || echo \"[Image: $(file -b \"$tmp\")]\"; else cat \"$tmp\"; fi; rm -f \"$tmp\"'"

        [keybindings]
        enter = "actions:copy"

        [actions.copy]
        command = "echo '{}' | cliphist decode 2>/dev/null | wl-copy"
        mode = "execute"
      '';

      home.shellAliases = {
        tv-text = "tv text";
        tv-apps = "tv apps";
        tv-clip = "tv clipboard";
      };
    };
}
