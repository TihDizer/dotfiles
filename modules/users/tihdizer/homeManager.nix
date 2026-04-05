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
        hm-tihdizer-home

        hm-tihdizer-niri
        hm-tihdizer-walker

        hm-tihdizer-utils-icons
        hm-tihdizer-files
        hm-tihdizer-dev

        hm-tihdizer-bash
        hm-tihdizer-web
        hm-tihdizer-utils-packages
        hm-tihdizer-utils-apps
        hm-tihdizer-utils-archives
        hm-tihdizer-utils-communication
        hm-tihdizer-utils-usb
        hm-tihdizer-yazi

        hm-tihdizer-shell
      ])
      ++ [
        inputs.niri.homeModules.niri
        inputs.walker.homeManagerModules.default
      ];
  };
}
