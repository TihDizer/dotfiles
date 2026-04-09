{ inputs, ... }:
{
  flake.modules.homeManager.hm-tihdizer-dev = {
    imports = with inputs.self.modules.homeManager; [
      hm-tihdizer-dev-zed-editor
      hm-tihdizer-dev-nix
      hm-tihdizer-dev-rust
      hm-tihdizer-dev-git
    ];
  };
}
