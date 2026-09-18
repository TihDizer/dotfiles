{ ... }:
{
  flake.modules.homeManager.chrome-server =
    { lib, pkgs, ... }:
    let
      commonArgs = [
        "${pkgs.google-chrome}/bin/google-chrome"
        "--remote-debugging-port=9222"
        "--remote-debugging-address=127.0.0.1"
        "--remote-allow-origins=*"
        "--user-data-dir=%h/.local/share/chrome-server"
        "--no-first-run"
        "--no-default-browser-check"
        "--disable-dev-shm-usage"
        "--disable-background-networking"
        "--disable-sync"
      ];
    in
    {
      systemd.user.services.chrome-headless = {
        Unit = {
          Description = "Google Chrome CDP Server (Headless)";
          After = [ "graphical-session.target" "network.target" ];
          Conflicts = [ "chrome-headed.service" ];
        };

        Service = {
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/.local/share/chrome-server";
          ExecStart = lib.concatStringsSep " \\\n  " (commonArgs ++ [ "--headless=new" ]);
          Restart = "on-failure";
          RestartSec = "5s";
        };

        Install = {
          Aliases = [ "chrome-server.service" ];
        };
      };

      systemd.user.services.chrome-headed = {
        Unit = {
          Description = "Google Chrome CDP Server (GUI / Window)";
          After = [ "graphical-session.target" "network.target" ];
          Conflicts = [ "chrome-headless.service" "chrome-server.service" ];
        };

        Service = {
          Environment = [ "NIXOS_OZONE_WL=1" ];
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/.local/share/chrome-server";
          ExecStart = lib.concatStringsSep " \\\n  " commonArgs;
          Restart = "on-failure";
          RestartSec = "5s";
        };
      };
    };
}
