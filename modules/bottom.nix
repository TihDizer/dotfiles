{ ... }:
{
  flake-file.inputs = { };

  flake.modules.nixos.bottom =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.bottom ];
    };

  flake.modules.homeManager.bottom =
    { ... }:
    {
      programs.bottom = {
        enable = true;
        settings = {
          flags = {
            temperature_type = "c";
            default_time_value = "30s";
            expanded_view = false;
            left_legend = true;
          };
        };
      };
    };
}
