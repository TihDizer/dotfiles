{ ... }:
{
  flake.modules.homeManager.tihdizer-walker =
    { ... }:
    {
      imports = [
        # inputs.self.modules.homeManager.tihdizer-walker-style
        # inputs.self.modules.homeManager.tihdizer-walker-layout
      ];

      programs.walker = {
        enable = true;
        runAsService = true;

        config = {
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
            icon-theme = "Papirus-Dark";
            icon-size = 48;
            corner-radius = 12;
            width = 800;
            height = 600;
          };

          search = {
            max-results = 20;
            fuzzy = true;
          };
        };
      };
    };
}
