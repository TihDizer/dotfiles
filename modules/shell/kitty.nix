{ ... }:
{
  flake.modules.nixos.kitty =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.kitty ];
    };

  flake.modules.homeManager.kitty =
    { pkgs, ... }:
    {
      programs.kitty = {
        enable = true;
        package = pkgs.kitty;
        settings = {
          enable_audio_bell = false;
          confirm_os_window_close = 0;
          check_urls_for_updates = false;
          linux_display_server = "wayland";
          show_tab_bar_meta = "no";
          hide_window_decorations = "yes";
          cursor_blink_interval = "0.5";
          cursor_stop_blinking_after = "0";
          window_padding_width = 4;
        };
      };
    };
}
