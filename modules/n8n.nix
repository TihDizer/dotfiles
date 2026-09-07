{ ... }:
let
  sharedPackages =
    pkgs: with pkgs; [
      n8n # Workflow automation tool
    ];

  sharedEnv = {
    N8N_HOST = "127.0.0.1";
    N8N_PORT = "5678";
    N8N_PROTOCOL = "http";
    N8N_METRICS = "true";
    EXECUTIONS_DATA_PRUNE = "true";
    EXECUTIONS_DATA_MAX_AGE = "168"; # 7 days in hours
  };
in
{
  flake.modules.nixos.n8n =
    { pkgs, ... }:
    {
      environment.systemPackages = sharedPackages pkgs;

      services.n8n = {
        enable = true;
        openFirewall = true;
        environment = sharedEnv;
      };
    };

  flake.modules.homeManager.n8n =
    { lib, pkgs, ... }:
    {
      home.packages = sharedPackages pkgs;

      systemd.user.services.n8n = {
        Unit = {
          Description = "n8n Workflow Automation";
          After = [ "network.target" ];
        };

        Service = {
          Environment = lib.mapAttrsToList (k: v: "${k}=${v}") sharedEnv;

          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/.local/share/n8n";
          ExecStart = "${pkgs.n8n}/bin/n8n";

          Restart = "on-failure";
          RestartSec = "5s";
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
}
