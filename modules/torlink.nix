{ inputs, ... }:
let
  getPackage = pkgs: inputs.torlink.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  flake-file.inputs = {
    torlink = {
      url = "github:baairon/torlink";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.torlink =
    { pkgs, ... }:
    {
      environment.systemPackages = [ (getPackage pkgs) ];
    };

  flake.modules.homeManager.torlink =
    { config, pkgs, ... }:
    {
      home.packages = [ (getPackage pkgs) ];

      xdg.configFile."torlink/config.json".text =
        let
          downloadDir = builtins.replaceStrings
            [ "$HOME" "~" ]
            [ config.home.homeDirectory config.home.homeDirectory ]
            config.xdg.userDirs.download;
        in
        builtins.toJSON {
          inherit downloadDir;
        };
    };
}
