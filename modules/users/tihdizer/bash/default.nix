{ ... }:
{
  flake.modules.homeManager.tihdizer-bash =
    { ... }:
    {
      programs.bash = {
        enable = true;
      };

      home.file.".ssh/config".text = ''
        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/id_ed25519_github
      '';
    };
}
