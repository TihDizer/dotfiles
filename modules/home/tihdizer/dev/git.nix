{ config, pkgs, ... }:

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
    };
  };
}
