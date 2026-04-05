{ inputs, ... }:
{
  flake.modules.homeManager.hm-tihdizer-files = {
    imports = with inputs.self.modules.homeManager; [
      hm-tihdizer-files-userdirs
    ];
  };
}
