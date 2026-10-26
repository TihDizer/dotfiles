{ inputs, ... }:
let
  cliproxyapi =
    pkgs:
    pkgs.stdenv.mkDerivation rec {
      pname = "CLIProxyAPI";
      version = "8.0.4";

      src = pkgs.fetchurl {
        url = "https://github.com/router-for-me/CLIProxyAPI/releases/download/v${version}/CLIProxyAPI_${version}_linux_amd64.tar.gz";
        hash = "sha256-85ZlPNYM0gSUcFwiGT0Rh43OEBaHu30GCHHBY6VzW7Y=";
      };

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall

        mkdir -p $out/bin
        cp cli-proxy-api $out/bin/cli-proxy-api
        ln -s $out/bin/cli-proxy-api $out/bin/cliproxyapi

        runHook postInstall
      '';

      meta = with pkgs.lib; {
        description = "Core CLI Proxy API";
        homepage = "https://github.com/router-for-me/CLIProxyAPI";
        platforms = [ "x86_64-linux" ];
        mainProgram = "cli-proxy-api";
      };
    };

  quotaInspector =
    pkgs:
    pkgs.stdenvNoCC.mkDerivation rec {
      pname = "CLIProxyAPI-Quota-Inspector";
      version = "0.4.0";

      src = pkgs.fetchurl {
        url = "https://github.com/AllenReder/CLIProxyAPI-Quota-Inspector/releases/download/v${version}/CLIProxyAPI-Quota-Inspector_${version}_linux_amd64.tar.gz";
        hash = "sha256-VGITPb5podNtErjfnAW+zUK1ki5tM/WQpSR6Jvnk9a4=";
      };

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall
        install -Dm755 cpa-quota-inspector $out/bin/cpa-quota-inspector
        runHook postInstall
      '';

      meta = with pkgs.lib; {
        description = "Quota inspector for CLIProxyAPI, including Codex, Gemini CLI, and Antigravity";
        homepage = "https://github.com/AllenReder/CLIProxyAPI-Quota-Inspector";
        license = licenses.mit;
        platforms = [ "x86_64-linux" ];
        mainProgram = "cpa-quota-inspector";
      };
    };

  ohMyCpa =
    pkgs:
    pkgs.stdenv.mkDerivation rec {
      pname = "oh-my-cpa";
      version = "0.3.9";

      src = pkgs.fetchurl {
        url = "https://github.com/WizisCool/oh-my-cpa/releases/download/v${version}/oh-my-cpa_${version}_linux_amd64.tar.gz";
        hash = "sha256-8E3U4XeCY9kaUtLxLUb6R/HKslj+7118F3cVVFSHdqk=";
      };

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall
        mkdir -p $out/bin
        install -Dm755 oh-my-cpa $out/bin/oh-my-cpa
        runHook postInstall
      '';

      meta = with pkgs.lib; {
        description = "Self-hosted management and usage observability for CLIProxyAPI";
        homepage = "https://github.com/WizisCool/oh-my-cpa";
        platforms = [ "x86_64-linux" ];
        mainProgram = "oh-my-cpa";
      };
    };
in
{
  flake-file.inputs = {
    oh-my-cpa-src = {
      url = "github:WizisCool/oh-my-cpa";
      flake = false;
    };
  };

  flake.packages.x86_64-linux.CLIProxyAPI = cliproxyapi (
    import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    }
  );

  flake.packages.x86_64-linux.CLIProxyAPI-Quota-Inspector = quotaInspector (
    import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    }
  );

  flake.packages.x86_64-linux.oh-my-cpa = ohMyCpa (
    import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    }
  );

  flake.modules.nixos.cli-proxy-api =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (cliproxyapi pkgs)
        (quotaInspector pkgs)
        (ohMyCpa pkgs)
      ];
    };

  flake.modules.homeManager.cli-proxy-api =
    { pkgs, ... }:
    {
      home.packages = [
        (cliproxyapi pkgs)
        (quotaInspector pkgs)
        (ohMyCpa pkgs)
      ];

      systemd.user.services.cli-proxy-api = {
        Unit = {
          Description = "CLIProxyAPI Background Service";
          After = [ "network.target" ];
        };
        Service = {
          Type = "simple";
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/.config/cli-proxy-api";
          ExecStart = "${cliproxyapi pkgs}/bin/cli-proxy-api -config config.yaml";
          WorkingDirectory = "%h/.config/cli-proxy-api";
          Restart = "on-failure";
          RestartSec = "5s";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };

      systemd.user.services.oh-my-cpa = {
        Unit = {
          Description = "Oh My CPA Management Dashboard";
          After = [
            "network.target"
            "cli-proxy-api.service"
          ];
          Wants = [ "cli-proxy-api.service" ];
        };
        Service = {
          Type = "simple";
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/.local/share/oh-my-cpa %h/.config/oh-my-cpa";
          ExecStart = "${ohMyCpa pkgs}/bin/oh-my-cpa";
          WorkingDirectory = "%h/.config/oh-my-cpa";
          Restart = "on-failure";
          RestartSec = "5s";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
}
