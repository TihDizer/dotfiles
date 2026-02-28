{
  description = "TihDizer NixOS + Home";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    zed = {
      url = "github:zed-industries/zed";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      niri,
      winapps,
      zapret-discord-youtube,
      rust-overlay,
      flake-utils,
      zed,
      walker,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.main = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            niri
            winapps
            zapret-discord-youtube
            system
            rust-overlay
            flake-utils
            zed
            walker
            ;
        };

        modules = [
          ./hosts/main/default.nix
          home-manager.nixosModules.home-manager
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit
                  niri
                  zed
                  walker
                  ;
              };

              users.tihdizer = import ./modules/home/tihdizer/default.nix;
            };
          }
        ];
      };
    };
}
