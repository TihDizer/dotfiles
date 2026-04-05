{ inputs, ... }:
{
  flake.modules.homeManager.hm-tihdizer-web = {
    imports = with inputs.self.modules.homeManager; [
      hm-tihdizer-web-chrome
      hm-tihdizer-web-firefox
    ];
  };
}
