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
              type = "custom";
              key = "󰾲 GPU";
              keyColor = "green";
              format = "AMD Radeon Vega 8 [Integrated]";
            }
            {
              type = "custom";
              key = "󰾲 GPU";
              keyColor = "green";
              format = "AMD Radeon RX 5700 XT [Discrete]";
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
              type = "disk";
              key = " Disk (/)";
              folders = "/";
              format = "{size-used} / {size-total} ({size-percentage})";
              keyColor = "magenta";
            }
            {
              type = "disk";
              key = " Disk (nvme)";
              folders = "/mnt/nvme";
              format = "{size-used} / {size-total} ({size-percentage})";
              keyColor = "magenta";
            }
            {
              type = "disk";
              key = " Disk (hdd1)";
              folders = "/mnt/hdd1";
              format = "{size-used} / {size-total} ({size-percentage})";
              keyColor = "magenta";
            }
            {
              type = "disk";
              key = " Disk (hdd2)";
              folders = "/mnt/hdd2";
              format = "{size-used} / {size-total} ({size-percentage})";
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
