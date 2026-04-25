{ inputs, ... }:
{
  flake-file.inputs = {
    niri.url = "github:sodiboo/niri-flake";

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  flake.modules.homeManager.tihdizer = {
    imports =
      (with inputs.self.modules.homeManager; [
        tihdizer-niri
        tihdizer-walker
        tihdizer-files
        tihdizer-git
        tihdizer-utils
        tihdizer-shell

        dev
        firefox
        chrome
        yazi
        mpv
        obsidian
        obs
        nixcord
        shell
      ])
      ++ [
        inputs.niri.homeModules.niri
        inputs.walker.homeManagerModules.default
      ];

    home.username = "tihdizer";
    home.homeDirectory = "/home/tihdizer";
    home.stateVersion = "26.05";
  };
}
