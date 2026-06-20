{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    niri-scratchpad = {
      url = "github:argosnothing/niri-scratchpad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.niri-scratchpad =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.niri-scratchpad.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
