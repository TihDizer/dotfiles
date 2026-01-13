{
  config,
  pkgs,
  ...
}:

{
  home.username = "tihdizer";
  home.homeDirectory = "/home/tihdizer";
  home.stateVersion = "25.05";

  programs.bash.enable = true;
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
