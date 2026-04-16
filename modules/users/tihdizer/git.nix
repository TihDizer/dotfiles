{ ... }:
{
  flake.modules.homeManager.tihdizer-git =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "tihdizer";
            email = "tihdizer@gmail.com";
          };
          credential.helper = "store";
          push.autoSetupRemote = true;
          init.defaultBranch = "main";
          url."git@github.com:".insteadOf = "https://github.com/";
        };
      };

      home.file.".ssh/config".text = ''
        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/id_ed25519_github
      '';
    };
}
