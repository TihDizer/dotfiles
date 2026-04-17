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
        tihdizer-home

        tihdizer-niri
        tihdizer-walker

        tihdizer-utils-icons
        tihdizer-files
        programs-dev
        tihdizer-git

        programs-firefox
        programs-chrome
        tihdizer-utils-packages
        tihdizer-utils-apps
        utils-mpv
        programs-office
        programs-obs
        utils-archives
        programs-nixcord
        tihdizer-utils-usb
        tihdizer-yazi
        programs-shell
        tihdizer-shell
      ])
      ++ [
        inputs.niri.homeModules.niri
        inputs.walker.homeManagerModules.default
      ];
  };
}
