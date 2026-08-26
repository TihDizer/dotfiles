{ ... }:
{
  flake.modules.homeManager.omniroute =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.services.omniroute;
    in
    {
      options.services.omniroute = {
        enable = lib.mkEnableOption "OmniRoute AI Gateway Podman Service";

        image = lib.mkOption {
          type = lib.types.str;
          default = "diegosouzapw/omniroute:latest";
          description = "Container image for OmniRoute.";
        };

        hostPort = lib.mkOption {
          type = lib.types.port;
          default = 8000;
          description = "Host port to map to OmniRoute.";
        };

        containerPort = lib.mkOption {
          type = lib.types.port;
          default = 20128;
          description = "Internal container port for OmniRoute.";
        };

        dataDir = lib.mkOption {
          type = lib.types.str;
          default = "${config.home.homeDirectory}/.local/share/omniroute";
          description = "Host path for persistent app data.";
        };

        environmentFile = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
          description = "Path to environment file containing secrets and API keys.";
        };

        extraEnv = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
          description = "Additional environment variables.";
        };
      };

      config = lib.mkMerge [
        {
          services.omniroute.enable = lib.mkDefault true;

          programs.ssh = {
            enable = true;

            matchBlocks = {
              omniroute = {
                hostname = "localhost";
                user = config.home.username;

                extraOptions = {
                  RequestTTY = "force";
                  RemoteCommand =
                    "${pkgs.podman}/bin/podman exec -it omniroute bash";
                };
              };
            };
          };
        }

        (lib.mkIf cfg.enable {
          home.packages = [ pkgs.podman ];

          systemd.user.services.omniroute = {
            Unit = {
              Description = "OmniRoute AI Gateway (Podman Container)";
              After = [ "network.target" ];
            };

            Service = {
              ExecStartPre = [
                "${pkgs.coreutils}/bin/mkdir -p ${cfg.dataDir}"
                "-${pkgs.podman}/bin/podman rm -f omniroute"
                "${pkgs.podman}/bin/podman pull ${cfg.image}"
              ];
              ExecStart =
                let
                  envFlags = lib.concatStringsSep " " (
                    lib.mapAttrsToList
                      (k: v: "-e ${k}=${lib.escapeShellArg v}")
                      (cfg.extraEnv // {
                        PORT = toString cfg.containerPort;
                      })
                  );

                  envFileFlag = lib.optionalString
                    (cfg.environmentFile != null)
                    "--env-file=${cfg.environmentFile}";
                in
                "${pkgs.podman}/bin/podman run --rm --name omniroute -p ${toString cfg.hostPort}:${toString cfg.containerPort} -v ${cfg.dataDir}:/app/data:U ${envFlags} ${envFileFlag} --stop-timeout=40 ${cfg.image}";

              ExecStop =
                "${pkgs.podman}/bin/podman stop --timeout 40 omniroute";

              Restart = "always";
              RestartSec = "5s";
            };

            Install = {
              WantedBy = [ "default.target" ];
            };
          };
        })
      ];
    };
}
