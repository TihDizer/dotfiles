{ ... }:
{
  flake.modules.nixos.fastfetch =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.fastfetch ];
    };

  flake.modules.homeManager.fastfetch =
    { ... }:
    {
      programs.fastfetch = {
        enable = true;
        settings = {
          "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
          logo = {
            type = "small";
            padding = {
              right = 2;
            };
          };
          display = {
            separator = "  ";
          };
          modules = [
            {
              type = "title";
              color = {
                user = "cyan";
                at = "white";
                host = "blue";
              };
            }
            {
              type = "separator";
              string = "─";
            }
            {
              type = "os";
              key = " OS";
              keyColor = "blue";
            }
            {
              type = "host";
              key = "󰌢 Host";
              keyColor = "blue";
            }
            {
              type = "kernel";
              key = " Kernel";
              keyColor = "blue";
            }
            {
              type = "uptime";
              key = " Uptime";
              keyColor = "blue";
            }
            {
              type = "packages";
              key = "󰏖 Packages";
              keyColor = "blue";
            }
            {
              type = "shell";
              key = " Shell";
              keyColor = "cyan";
            }
            {
              type = "display";
              key = "󰍹 Display";
              keyColor = "cyan";
              compactType = "original";
            }
            {
              type = "wm";
              key = " WM";
              keyColor = "cyan";
            }
            {
              type = "terminal";
              key = " Terminal";
              keyColor = "cyan";
            }
            {
              type = "cpu";
              key = " CPU";
              keyColor = "green";
            }
            {
              type = "memory";
              key = " Memory";
              keyColor = "magenta";
            }
            {
              type = "swap";
              key = "󰓡 Swap";
              keyColor = "magenta";
            }
            {
              type = "localip";
              key = "󰩟 Local IP";
              keyColor = "yellow";
              showIpv6 = false;
            }
            {
              type = "locale";
              key = " Locale";
              keyColor = "yellow";
            }
            "break"
            {
              type = "colors";
              symbol = "circle";
            }
          ];
        };
      };
    };
}
