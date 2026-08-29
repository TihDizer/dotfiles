{ ... }:
{
  flake.modules.homeManager.lab-ubuntu =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      containerName = "ubuntu-container";
      image = "docker.io/library/ubuntu:latest";
      hostname = "ubuntu-dev";
      dataDir = "${config.home.homeDirectory}/.local/share/ubuntu-container";
    in
    {
      home.packages = [ pkgs.podman ];

      programs.ssh = {
        enable = true;

        settings.lab-ubuntu = {
          hostname = "localhost";
          user = config.home.username;
          requestTTY = "force";
          remoteCommand = "${pkgs.podman}/bin/podman exec -it ${containerName} bash";
        };
      };

      systemd.user.services.lab-ubuntu = {
        Unit = {
          Description = "Ubuntu Dev Environment (Podman Container)";
          After = [ "network.target" ];
        };

        Service = {
          ExecStartPre = [
            "${pkgs.coreutils}/bin/mkdir -p ${dataDir}"
            "-${pkgs.podman}/bin/podman rm -f ${containerName}"
            "${pkgs.podman}/bin/podman pull ${image}"
          ];

          ExecStart = lib.concatStringsSep " \\\n  " [
            "${pkgs.podman}/bin/podman run --rm"
            "--name ${containerName}"
            "--hostname ${hostname}"
            "--cpus=2"
            "--memory=4g"
            "-p 2222:22"
            "-p 8080:80"
            "-v ${dataDir}:/data:U"
            "-v /var/run/docker.sock:/var/run/docker.sock"
            "-e TZ=Europe/Moscow"
            "-e LANG=en_US.UTF-8"
            "--stop-timeout=40"
            "${image} /bin/bash -c 'trap : TERM INT; sleep infinity & wait'"
          ];

          ExecStop = "${pkgs.podman}/bin/podman stop --timeout 40 ${containerName}";

          Restart = "on-failure";
          RestartSec = "5s";
        };
      };
    };
}
