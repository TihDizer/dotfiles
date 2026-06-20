{
  inputs,
  ...
}:
{
  # Setup of tools for dendritic pattern

  # Simplify Nix Flakes with the module system
  # https://github.com/hercules-ci/flake-parts

  # Generate flake.nix from module options.
  # https://github.com/vic/flake-file

  flake-file.inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-file = {
      url = "github:vic/flake-file";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-file.flakeModules.default
  ];

  # import all modules recursively
  flake-file.outputs = ''
    inputs: let
      inherit (inputs.nixpkgs) lib;
      inherit (lib.fileset) toList fileFilter;

      isNixModule = file:
        file.hasExt "nix"
        && file.name != "flake.nix"
        && !lib.hasPrefix "_" file.name
        && !lib.hasSuffix "template" file.name;

      importTree = path:
        toList (fileFilter isNixModule path);

      mkFlake = inputs.flake-parts.lib.mkFlake { inherit inputs; };
    in
      mkFlake {
        imports = importTree ./.;
      }
  '';

  # set flake.systems
  systems = [
    "x86_64-linux"
  ];
}
