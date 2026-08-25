{ inputs, ... }:
{
  flake-file.inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
      inputs.nixpkgs.follows = "nixpkgs";
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

        sops
        dev
        firefox
        chrome
        bottom
        yazi
        mpv
        obsidian
        obs
        nixcord
        shell
        television
        omniroute
        jcode
        nirimap
        usb
      ])
      ++ [
        inputs.niri.homeModules.niri
        inputs.walker.homeManagerModules.default
      ];

    home.username = "tihdizer";
    home.homeDirectory = "/home/tihdizer";
    home.pointerCursor.enable = true;
    home.stateVersion = "26.05";
  };
}
