{ ... }:
{
  flake.modules.nixos.atuin =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.atuin ];
    };

  flake.modules.homeManager.atuin =
    { ... }:
    {
      programs.atuin = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;

        # flags = [ "--disable-up-arrow" ];

        settings = {
          auto_sync = true;
          update_check = false;
          search_mode = "fuzzy";
          filter_mode = "global";
          style = "compact";
          inline_height = 0;
          show_preview = true;
        };
      };
    };
}
