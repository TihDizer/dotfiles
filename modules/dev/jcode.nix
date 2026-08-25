{ inputs, ... }:
{
  flake-file.inputs = {
    jcode-src = {
      url = "github:1jehuang/jcode";
      flake = false;
    };
  };

  flake.modules.homeManager.jcode =
    { config, lib, pkgs, ... }:
    {

      options.programs.jcode = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "jcode";
            version = "unstable";

            src = inputs.jcode-src;

            doCheck = false;

            nativeBuildInputs = [ pkgs.pkg-config ];
            buildInputs = [ pkgs.openssl ];

            cargoHash = "sha256-QUfkbunDf4L1iehKsqvxSX3QkkL2HOIEhkc5sVmPCrA=";
          };
          description = "The jcode package built from source via flake";
        };
      };

      config = {
        home.packages = [ config.programs.jcode.package ];

        home.file.".config/jcode/config.toml".text = ''
          default_provider = "openai"

          [providers.openai]
          type = "openai"
          base_url = "http://localhost:8000/v1"
          api_key = "sk-omniroute"

          [auth]
          auto_login = false
        '';
      };
    };
}
