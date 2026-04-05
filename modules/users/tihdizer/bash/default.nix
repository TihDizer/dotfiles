{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-bash =
    { ... }:
    {
      programs.bash = {
        enable = true;
        bashrcExtra = builtins.readFile ./bashrc;
      };

      home.file.".profile".text = ''
        if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec niri-session
        fi
      '';
      home.file.".bashrc".force = true;

      home.file.".ssh/config".text = ''
        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/id_ed25519_github
      '';
    };
}
