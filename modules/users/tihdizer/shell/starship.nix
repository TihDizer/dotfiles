{ ... }:
{
  flake.modules.homeManager.tihdizer-shell-starship =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.fish.enable = lib.mkDefault true;
      programs.zsh.enable = lib.mkDefault true;
      programs.zsh.initContent = lib.mkAfter ''
        ZLE_RPROMPT_INDENT=0
      '';

      home.packages = with pkgs; [ starship ];
      programs.starship = {
        enable = true;
        package = pkgs.starship;
        enableZshIntegration = config.programs.zsh.enable;
        enableFishIntegration = config.programs.fish.enable;
        settings = {
          add_newline = false;
          command_timeout = 1300;
          right_format = "$nix_shell$all";
          format = "$shlvl$character";
          scan_timeout = 50;
          shell = {
            disabled = false;
            bash_indicator = "bsh";
            zsh_indicator = "zsh";
            fish_indicator = "fsh";
          };
          shlvl = {
            disabled = false;
            format = "$symbol";
            repeat = true;
            symbol = "❯";
            repeat_offset = 1;
          };
          character = {
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
