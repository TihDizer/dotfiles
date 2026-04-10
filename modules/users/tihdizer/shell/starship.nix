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
          format = "$shlvl$character";
          scan_timeout = 50;
          shell = {
            disabled = false;
            bash_indicator = "bsh";
          };
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
            vimcmd_symbol = "❮";
          };
          directory = {
            read_only = " ";
          };
        };
      };
    };
}
