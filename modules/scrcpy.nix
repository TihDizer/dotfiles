{ ... }:
{
  flake.modules.nixos.scrcpy =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        scrcpy
        android-tools
      ];
    };

  flake.modules.homeManager.scrcpy =
    { pkgs, ... }:
    let
      phone = pkgs.writeShellScriptBin "phone" ''
        set -e
        PHONE_IP="''${PHONE_IP:-192.168.31.12}"

        if ${pkgs.android-tools}/bin/adb devices | ${pkgs.gnugrep}/bin/grep -qE "^$PHONE_IP:[0-9]+[[:space:]]+device$"; then
          exec ${pkgs.scrcpy}/bin/scrcpy -S --audio-source=output --window-height=1080 --shortcut-mod=lalt "$@"
        fi

        ${pkgs.android-tools}/bin/adb disconnect >/dev/null 2>&1 || true

        echo "Discovering phone on Wi-Fi ($PHONE_IP)..."
        ports=$(${pkgs.nmap}/bin/nmap -p 30000-50000 "$PHONE_IP" -T4 --open -oG - 2>/dev/null | ${pkgs.gnugrep}/bin/grep -oP '\d+(?=/open)')

        if [ -z "$ports" ]; then
          echo "Error: Phone not reachable at $PHONE_IP or Wireless debugging is disabled."
          exit 1
        fi

        connected=0
        for port in $ports; do
          ${pkgs.coreutils}/bin/timeout 2 ${pkgs.android-tools}/bin/adb connect "$PHONE_IP:$port" >/dev/null 2>&1 || true
          if ${pkgs.android-tools}/bin/adb devices | ${pkgs.gnugrep}/bin/grep -qE "^$PHONE_IP:$port[[:space:]]+device$"; then
            echo "Connected to $PHONE_IP:$port"
            connected=1
            break
          else
            ${pkgs.android-tools}/bin/adb disconnect "$PHONE_IP:$port" >/dev/null 2>&1 || true
          fi
        done

        if [ "$connected" -eq 1 ]; then
          exec ${pkgs.scrcpy}/bin/scrcpy -S --audio-source=output --window-height=1080 --shortcut-mod=lalt "$@"
        else
          echo "Error: Could not connect to phone. Make sure Wireless debugging is enabled."
          exit 1
        fi
      '';
    in
    {
      home.packages = with pkgs; [
        scrcpy
        android-tools
        phone
      ];

      xdg.desktopEntries.phone = {
        name = "Phone";
        genericName = "Android Screen Mirroring";
        comment = "Mirror Android phone screen wirelessly";
        exec = "${phone}/bin/phone";
        icon = "scrcpy";
        terminal = false;
        categories = [
          "Utility"
          "RemoteAccess"
        ];
      };
    };
}
