{ ... }:
let
  smolsonicPkg =
    pkgs:
    let
      version = "0.10.1";
    in
    pkgs.stdenv.mkDerivation {
      pname = "smolsonic";
      inherit version;

      src = pkgs.fetchurl {
        url = "https://github.com/tsirysndr/smolsonic/releases/download/v${version}/smolsonic-v${version}-linux-amd64.tar.gz";
        hash = "sha256-TL++T2bHdgLMyztRtWjn5unnsQfr1syIoWKgfB21d4w=";
      };

      nativeBuildInputs = [ pkgs.autoPatchelfHook ];
      buildInputs = [ pkgs.stdenv.cc.cc.lib ];

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall
        install -Dm755 smolsonic $out/bin/smolsonic
        runHook postInstall
      '';

      meta = with pkgs.lib; {
        description = "A tiny Subsonic + Jellyfin server + S3 API written in Rust";
        homepage = "https://github.com/tsirysndr/smolsonic";
        platforms = [ "x86_64-linux" ];
        mainProgram = "smolsonic";
      };
    };
in
{
  flake.modules.nixos.music-smolsonic =
    { config, pkgs, ... }:
    let
      smolsonic = smolsonicPkg pkgs;
    in
    {
      sops.secrets.smolsonic_user = {
        sopsFile = ../../secrets/music-secrets.yaml;
      };
      sops.secrets.smolsonic_password = {
        sopsFile = ../../secrets/music-secrets.yaml;
      };

      sops.templates."smolsonic-1.toml" = {
        content = ''
          music_dir = "/var/media/music"
          username = "${config.sops.placeholder.smolsonic_user}"
          password = "${config.sops.placeholder.smolsonic_password}"
          port = 4534
          host = "127.0.0.1"
          database_path = "/var/lib/smolsonic-1/smolsonic.db"
          covers_dir = "/var/lib/smolsonic-1/covers"

          [jellyfin]
          port = 8096
          host = "127.0.0.1"
          server_name = "Smolsonic 1"

          [mdns]
          enabled = false
        '';
        mode = "0600";
        owner = "root";
      };

      sops.templates."smolsonic-2.toml" = {
        content = ''
          music_dir = "/var/media/music"
          username = "${config.sops.placeholder.smolsonic_user}"
          password = "${config.sops.placeholder.smolsonic_password}"
          port = 4535
          host = "127.0.0.1"
          database_path = "/var/lib/smolsonic-2/smolsonic.db"
          covers_dir = "/var/lib/smolsonic-2/covers"

          [jellyfin]
          port = 8097
          host = "127.0.0.1"
          server_name = "Smolsonic 2"

          [mdns]
          enabled = false
        '';
        mode = "0600";
        owner = "root";
      };

      systemd.tmpfiles.rules = [
        "d /var/media/music 0755 tihdizer users -"
      ];

      systemd.services.smolsonic-1 = {
        description = "Smolsonic Subsonic Server (Instance 1)";
        after = [
          "network.target"
          "rclone-r2-music.service"
        ];
        wants = [ "rclone-r2-music.service" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type = "simple";
          StateDirectory = "smolsonic-1";
          WorkingDirectory = "/var/lib/smolsonic-1";
          ExecStart = "${smolsonic}/bin/smolsonic --config ${config.sops.templates."smolsonic-1.toml".path}";
          Restart = "on-failure";
          RestartSec = "10s";
        };
      };

      systemd.services.smolsonic-2 = {
        description = "Smolsonic Subsonic Server (Instance 2)";
        after = [
          "network.target"
          "rclone-r2-music.service"
        ];
        wants = [ "rclone-r2-music.service" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type = "simple";
          StateDirectory = "smolsonic-2";
          WorkingDirectory = "/var/lib/smolsonic-2";
          ExecStart = "${smolsonic}/bin/smolsonic --config ${config.sops.templates."smolsonic-2.toml".path}";
          Restart = "on-failure";
          RestartSec = "10s";
        };
      };
    };
}
