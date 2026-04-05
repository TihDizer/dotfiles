{ inputs, ... }:
{
  flake-file.inputs = {
    zed = {
      url = "github:zed-industries/zed";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.hm-tihdizer-dev-zed-editor =
    { pkgs, ... }:
    {
      programs.zed-editor = {
        enable = true;
        package = inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default;
        userSettings = {
          auto_install_extensions = {
            "dockerfile" = true;
            "toml" = true;
            "html" = true;
            "git-firefly" = true;
            "nix" = true;
            "docker-compose" = true;
            "sql" = true;
            "terraform" = true;
            "latex" = true;
            "csv" = true;
            "ansible" = true;
            "rust-snippets" = true;
            "rust-go-snippets" = true;
            "python-snippets" = true;
            "proto" = true;
          };
          edit_predictions = {
            mode = "subtle";
          };
          window_decorations = "server";
          calls = {
            mute_on_join = true;
          };
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          base_keymap = "JetBrains";
          autosave = "on_focus_change";
          languages.Markdown = {
            remove_trailing_whitespace_on_save = false;
            show_whitespaces = "all";
          };
          agent = {
            default_profile = "ask";
            default_model = {
              provider = "openrouter";
              model = "openrouter/free";
            };
            favorite_models = [ ];
            model_parameters = [ ];
          };
          vim_mode = true;
          restore_on_startup = "launchpad";
        };
      };
    };
}
