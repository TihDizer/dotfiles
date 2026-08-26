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

      programs.ssh = {
        enable = true;
        settings = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.ssh/id_ed25519_github";
          };
        };
      };
    };
}
