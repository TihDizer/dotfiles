{ inputs, ... }:
let
  getPackage = pkgs: inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  flake-file.inputs = {
    matugen = {
      url = "github:InioX/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.matugen =
    { pkgs, ... }:
    {
      environment.systemPackages = [ (getPackage pkgs) ];
    };

  flake.modules.homeManager.matugen =
    { pkgs, ... }:
    {
      home.packages = [ (getPackage pkgs) ];
    };
}
