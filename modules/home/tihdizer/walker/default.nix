{
  pkgs,
  lib,
  walker,
  ...
}:
{
  imports = [
    # ./style.nix
    # ./layout.nix
  ];

  programs.walker = {
    enable = true;

    settings = {
      providers = {
        calculator.enable = true;
        files.enable = true;
        web.enable = true;
        command.enable = true;
        clipboard.enable = true;
        symbols.enable = true;
        bluetooth.enable = true;
        todo.enable = true;
        elephant.enable = true;
      };

      appearance = {
        font = "JetBrains Mono Nerd Font 14";
        theme = "dark";
        corner-radius = 12;
        width = 800;
        height = 600;
      };

      search = {
        max-results = 20;
        fuzzy = true;
      };
    };

    package = walker.packages.${pkgs.system}.default;
  };
}
