{ inputs, ... }:
let
  getPackage = pkgs:
    inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (_: {
      RUSTFLAGS = "-C link-arg=-lgcc";
    });
in
{
  flake-file.inputs = {
    herdr = {
      url = "github:herdrdev/herdr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.herdr =
    { pkgs, ... }:
    {
      environment.systemPackages = [ (getPackage pkgs) ];
    };

  flake.modules.homeManager.herdr =
    { pkgs, ... }:
    {
      home.packages = [ (getPackage pkgs) ];

      xdg.configFile."herdr/config.toml".text = ''
        [theme]
        name = "terminal"
      '';
    };
}
