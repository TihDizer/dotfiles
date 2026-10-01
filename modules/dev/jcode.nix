{ inputs, ... }:
let
  jcodeConfigTemplate = apiKey: ''
    [provider]
    default_provider = "ai-proxy"
    default_model = "auto"
    model_picker_providers = ["ai-proxy"]
    openai_reasoning_effort = "high"

    [providers.ai-proxy]
    type = "openai-compatible"
    base_url = "http://localhost:8317/v1"
    api_key = "${apiKey}"
    model_catalog = true
    supports_reasoning_effort = true

    [gateway]
    enabled = true
  '';
in
{
  flake-file.inputs = {
    jcode-src = {
      url = "github:1jehuang/jcode";
      flake = false;
    };
  };

  flake.modules.nixos.jcode =
    { config, ... }:
    {
      sops.secrets."ai-proxy" = { };

      systemd.tmpfiles.rules = [
        "d /home/tihdizer/.jcode 0700 tihdizer users -"
      ];

      sops.templates."jcode-config.toml" = {
        path = "/home/tihdizer/.jcode/config.toml";
        content = jcodeConfigTemplate "${config.sops.placeholder."ai-proxy"}";
        mode = "0600";
        owner = "tihdizer";
        group = "users";
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

            cargoHash = "sha256-1A3o/f+VTWNEgiRuQRNp8Q2MsBfwjT8sg8JpEBVtiqo=";
          };
          description = "The jcode package built from source via flake";
        };
      };

      config = {
        home.packages = [ config.programs.jcode.package ];
      };
    };
}
