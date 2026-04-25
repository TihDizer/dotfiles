{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    niri-scratchpad.url = "github:argosnothing/niri-scratchpad";
  };

  flake.modules.nixos.niri-scratchpad =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.niri-scratchpad.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
