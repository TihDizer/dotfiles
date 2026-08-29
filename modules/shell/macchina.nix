{ ... }:
{
  flake.modules.nixos.macchina =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.macchina ];
    };

  flake.modules.homeManager.macchina =
    { ... }:
    {
      programs.macchina = {
        enable = true;
        settings = {
          theme = "magic";
          interface = "enp42s0";
          long_uptime = false;
          long_shell = false;
          long_kernel = false;
          current_shell = true;
          physical_cores = false;
          memory_percentage = true;
          show = [
            "Host"
            "Kernel"
            "Packages"
            "LocalIP"
            "Uptime"
            "Memory"
          ];
        };
        themes.magic = {
          spacing = 2;
          padding = 0;
          hide_ascii = true;
          separator = ">";
          key_color = "Yellow";
          separator_color = "Red";

          palette = {
            type = "Dark";
            visible = true;
            glyph = "● ";
          };

          bar = {
            visible = false;
          };

          box = {
            title = "  NixOS ";
            border = "rounded";
            visible = true;
            inner_margin = {
              x = 1;
              y = 0;
            };
          };

          keys = {
            host = "User";
            kernel = "Kernel";
            packages = "Packages";
            local_ip = "Local IP";
            uptime = "Uptime";
            memory = "Memory";
            battery = "Battery";
            distro = "Distro";
            machine = "Machine";
            terminal = "Terminal";
            shell = "Shell";
            cpu = "CPU";
            disk_space = "Disk Space";
            de = "DE";
            wm = "WM";
          };
        };
      };
    };
}
