{ inputs, ... }:
{
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.sops =
    { ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        validateSopsFiles = false;

        age.keyFile = "/var/lib/sops-nix/key.txt";

        secrets.subscription = { };
      };
    };

  flake.modules.homeManager.sops =
    { pkgs, ... }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      home.packages = with pkgs; [
        sops
        age
      ];
    };
}
