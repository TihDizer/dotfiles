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
        command = 'echo "$XDG_DATA_DIRS" | tr ":" "\n" | xargs -I {} find {}/applications -name "*.desktop" 2>/dev/null | xargs -I {} basename {} .desktop | sort -u'

        [preview]
        command = 'echo "$XDG_DATA_DIRS" | tr ":" "\n" | xargs -I {} find {}/applications -name "{}.desktop" 2>/dev/null | head -n1 | xargs grep -E "^(Name|Comment|Exec)=" 2>/dev/null'

        [keybindings]
        enter = "actions:launch"

        [actions.launch]
        command = "nohup gtk-launch '{}' > ~/.cache/television-launch.log 2>&1 &"
        mode = "execute"
      '';

      home.file.".config/television/cable/clipboard.toml".text = ''
        [metadata]
        name = "clipboard"
        description = "Clipboard history manager (cliphist)"

        [source]
        command = "cliphist list"

        [preview]
        command = "echo '{}' | cliphist decode"

        [keybindings]
        enter = "actions:copy"

        [actions.copy]
        command = "echo '{}' | cliphist decode | wl-copy"
        mode = "execute"
      '';

      home.shellAliases = {
        tv-text = "tv text";
        tv-apps = "tv apps";
        tv-clip = "tv clipboard";
      };
    };
}
