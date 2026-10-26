{ inputs, ... }:
let
  getPackage = pkgs: inputs.aven.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  flake-file.inputs = {
    aven = {
      url = "github:raine/aven";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.aven =
    { pkgs, ... }:
    {
      environment.systemPackages = [ (getPackage pkgs) ];
    };

  flake.modules.homeManager.aven =
    { pkgs, ... }:
    {
      home.packages = [ (getPackage pkgs) ];
    };
}
