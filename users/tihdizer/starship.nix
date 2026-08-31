{ ... }:
let
  commonSettings = {
    add_newline = false;
    command_timeout = 1300;
    scan_timeout = 50;
    jobs.disabled = true;
    shell.disabled = true;
    character = {
      success_symbol = "❯";
      error_symbol = "";
      vimcmd_symbol = "❮";
    };
    directory = {
      read_only = " ";
    };
  };

  defaultSettings = commonSettings // {
    format = "$directory$shlvl$character";
    right_format = "$git_branch$git_status$nix_shell$cmd_duration";
    shlvl = {
      disabled = false;
      format = "$symbol";
      repeat = true;
      symbol = "❯";
      repeat_offset = 1;
    };
  };

  tmuxSettings = commonSettings // {
    format = "$character";
    right_format = "$git_branch$git_status$nix_shell$cmd_duration";
    shlvl.disabled = true;
    directory.disabled = true;
  };
in
{
  flake.modules.homeManager.tihdizer-starship =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.fish.enable = lib.mkDefault true;
      programs.zsh = {
        enable = lib.mkDefault true;
        initExtra = ''
          ZLE_RPROMPT_INDENT=0
        '';
      };
      home.packages = with pkgs; [ starship ];

      programs.starship = {
        enable = true;
        package = pkgs.starship;
        enableZshIntegration = config.programs.zsh.enable;
        enableFishIntegration = config.programs.fish.enable;
        settings = defaultSettings;
      };

      xdg.configFile."starship-tmux.toml".source =
        (pkgs.formats.toml { }).generate "starship-tmux.toml" tmuxSettings;
    };
}

