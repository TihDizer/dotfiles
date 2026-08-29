{ inputs, ... }:
let
  nixSettings = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  getPackage = pkgs: inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr;
in
{
  flake-file.inputs = {
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.herdr =
    { pkgs, ... }:
    {
      nix.settings = nixSettings;
      environment.systemPackages = [ (getPackage pkgs) ];
    };

  flake.modules.homeManager.herdr =
    { pkgs, ... }:
    {
      nix.settings = nixSettings;
      home.packages = [ (getPackage pkgs) ];

      xdg.configFile."herdr/config.toml".text = ''
        [theme]
        name = "terminal"
      '';
    };
}
