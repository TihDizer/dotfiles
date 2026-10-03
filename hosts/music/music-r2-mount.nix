{ ... }:
{
  flake.modules.nixos.music-r2-mount =
    {
      config,
      pkgs,
      ...
    }:
    let
      rclonePkg = pkgs.rclone;
      mountScript = pkgs.writeShellScript "rclone-r2-mount" ''
        mkdir -p /var/media/music
        BUCKET="$(< ${config.sops.secrets.r2_bucket.path})"
        exec ${rclonePkg}/bin/rclone mount "r2:$BUCKET" /var/media/music \
          --config ${config.sops.templates."rclone-r2.conf".path} \
          --allow-other \
          --allow-non-empty \
          --uid 1000 \
          --gid 100 \
          --umask 022 \
          --vfs-cache-mode full \
          --vfs-cache-max-size 10G \
          --vfs-cache-max-age 72h \
          --dir-cache-time 1m \
          --vfs-read-chunk-size 2M \
          --vfs-read-chunk-size-limit 64M \
          --buffer-size 16M
      '';
    in
    {
      programs.fuse.userAllowOther = true;

      sops.secrets.r2_account_id = {
        sopsFile = ../../secrets/music-secrets.yaml;
      };
      sops.secrets.r2_access_key_id = {
        sopsFile = ../../secrets/music-secrets.yaml;
      };
      sops.secrets.r2_secret_access_key = {
        sopsFile = ../../secrets/music-secrets.yaml;
      };
      sops.secrets.r2_bucket = {
        sopsFile = ../../secrets/music-secrets.yaml;
      };

      sops.templates."rclone-r2.conf" = {
        content = ''
          [r2]
          type = s3
          provider = Cloudflare
          access_key_id = ${config.sops.placeholder.r2_access_key_id}
          secret_access_key = ${config.sops.placeholder.r2_secret_access_key}
          endpoint = https://${config.sops.placeholder.r2_account_id}.r2.cloudflarestorage.com
          acl = private
          no_check_bucket = true
        '';
        mode = "0600";
        owner = "root";
      };

      systemd.services.rclone-r2-music = {
        description = "Mount Cloudflare R2 bucket to /var/media/music";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = mountScript;
          ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u -z /var/media/music";
          Restart = "on-failure";
          RestartSec = "10s";
        };
      };
    };
}
