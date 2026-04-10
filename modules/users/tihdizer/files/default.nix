{ inputs, ... }:
{
  flake.modules.homeManager.tihdizer-files = {
    imports = with inputs.self.modules.homeManager; [
      tihdizer-files-userdirs
    ];
  };
}
