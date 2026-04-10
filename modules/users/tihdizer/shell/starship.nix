{ ... }:
{
  flake.modules.homeManager.tihdizer-shell-starship =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ starship ];
      programs.starship = {
        enable = true;
        package = pkgs.starship;
        settings = {
          add_newline = false;
          command_timeout = 1300;
          format = "$all$character";
          scan_timeout = 50;
          character = {
            # TODO: Stylix
            success_symbol = "";
            error_symbol = "✗";
          };
        };
      };
    };
}
