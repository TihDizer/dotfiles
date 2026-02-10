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

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      niri,
      winapps,
      zapret-discord-youtube,
      antigravity-nix,
      rust-overlay,
      flake-utils,
      zed,
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
            antigravity-nix
            rust-overlay
            flake-utils
            zed
            ;
        };

        modules = [
          ./hosts/main/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit niri antigravity-nix zed; };

              users.tihdizer = import ./modules/home/tihdizer/default.nix;
            };
          }
        ];
      };
    };
}
