{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gitFull
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "TihDizer";
    userEmail = "tihdizer@gmail.com";

    extraConfig = {
      credential = {
        helper = "libsecret";
      };

      credential."https://github.com".username = "TihDizer";
    };
  };
}
