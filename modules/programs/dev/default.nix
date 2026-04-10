{ inputs, ... }:
{
  flake.modules.homeManager.programs-dev = {
    imports = with inputs.self.modules.homeManager; [
      programs-dev-zed-editor
      programs-dev-nix
      programs-dev-rust
    ];
  };
}
