{ ... }:
{
  flake.modules.nixos.music-litestream =
    {
      config,
      pkgs,
      ...
    }:
    let
      rcloneConf = config.sops.templates."rclone-r2.conf".path;
      backupScript = pkgs.writeShellScript "backup-smolsonic-db" ''
        set -euo pipefail
        BUCKET="$(< ${config.sops.secrets.r2_bucket.path})"
        BACKUP_DIR="$(mktemp -d)"
        trap 'rm -rf "$BACKUP_DIR"' EXIT

        for inst in 1 2; do
          DB="/var/lib/smolsonic-$inst/smolsonic.db"
          if [ -f "$DB" ]; then
            echo "Backing up smolsonic-$inst database..."
            ${pkgs.sqlite}/bin/sqlite3 "$DB" ".backup '$BACKUP_DIR/smolsonic-$inst.db'"
          fi
        done

        echo "Uploading database backups to R2..."
        ${pkgs.rclone}/bin/rclone copy "$BACKUP_DIR" "r2:$BUCKET/backups/db" \
          --config "${rcloneConf}"
        echo "Backup complete."
      '';
    in
    {
      systemd.services.smolsonic-db-backup = {
        description = "Daily Smolsonic SQLite Database Backup to Cloudflare R2";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];

        serviceConfig = {
          Type = "oneshot";
          ExecStart = backupScript;
        };
      };

      systemd.timers.smolsonic-db-backup = {
        description = "Trigger nightly Smolsonic SQLite backup";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "03:00";
          Persistent = true;
          RandomizedDelaySec = "15m";
        };
      };
    };
}
