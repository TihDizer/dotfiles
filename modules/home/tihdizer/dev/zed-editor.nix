{ pkgs, zed, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = zed.packages.${pkgs.system}.default;
    extensions = [
      "nix"
      "rust"
      "toml"
      "markdown"
      "dockerfile"
    ];
    userSettings = {
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
    };
  };
}
