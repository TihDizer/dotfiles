{ inputs, ... }:
{
  flake-file.inputs = {
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.programs-desktop-winapps =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.winapps.packages.${pkgs.system}.winapps
        inputs.winapps.packages.${pkgs.system}.winapps-launcher # optional
      ];
    };
}
