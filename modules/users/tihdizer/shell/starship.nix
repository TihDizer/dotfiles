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
          right_format = "$all";
          format = "$character";
          scan_timeout = 50;
          shlvl = {
            disabled = false;
            format = "$symbol";
            repeat = true;
            symbol = "❯";
            repeat_offset = 1;
          };
          character = {
            # TODO: Stylix
            success_symbol = "❯";
            error_symbol = "";
          };
        };
      };
    };
}
