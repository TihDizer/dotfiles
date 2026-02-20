{ pkgs, zed, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = zed.packages.${pkgs.system}.default;
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
      ui_font_size = 16;
      buffer_font_size = 15;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };
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
}
