# ==============================================================================
# AI Generated - Daily Art Wallpaper module (awww + Met Museum Collection API)
# ==============================================================================
{ ... }:
{
  flake.modules.homeManager.wallpaper =
    {
      pkgs,
      lib,
      ...
    }:
    let
      dailyArtScript = pkgs.writeShellScriptBin "daily-art-wallpaper" ''
        set -euo pipefail
        export PATH="${
          lib.makeBinPath [
            pkgs.awww
            pkgs.curl
            pkgs.jq
            pkgs.imagemagick
            pkgs.coreutils
            pkgs.findutils
            pkgs.libnotify
          ]
        }:$PATH"

        CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/art-wallpaper"
        mkdir -p "$CACHE_DIR"

        FORCE=0
        RANDOM_PICK=0

        for arg in "$@"; do
            case "$arg" in
                -f|--force) FORCE=1 ;;
                -r|--random) RANDOM_PICK=1 ;;
            esac
        done

        TODAY=$(date +%Y-%m-%d)

        # Ensure awww-daemon is running and responsive
        if ! awww query >/dev/null 2>&1; then
            rm -f "/run/user/$(id -u)/wayland-"*"-awww-daemon"*.sock 2>/dev/null || true
            awww-daemon &
            sleep 1
        fi

        # Discover active outputs from awww query
        OUTPUTS_INFO=$(awww query 2>/dev/null || true)
        if [ -z "$OUTPUTS_INFO" ]; then
            sleep 0.8
            OUTPUTS_INFO=$(awww query 2>/dev/null || true)
        fi

        if [ -n "$OUTPUTS_INFO" ]; then
            mapfile -t OUTPUT_NAMES < <(echo "$OUTPUTS_INFO" | grep -oP '(?<=: )[^:]+(?=: \d+x\d+)')
            mapfile -t OUTPUT_RES < <(echo "$OUTPUTS_INFO" | grep -oP '\d+x\d+(?=,)')
        else
            OUTPUT_NAMES=("HDMI-A-1" "DP-3" "DP-5")
            OUTPUT_RES=("3840x2160" "1920x1080" "1920x1080")
        fi

        # Fetch highlight paintings collection
        SEARCH_RESP=$(curl -s --max-time 15 "https://collectionapi.metmuseum.org/public/collection/v1/search?hasImages=true&isHighlight=true&q=painting" || true)
        TOTAL_COUNT=$(echo "$SEARCH_RESP" | jq -r '.total // 0')

        for i in "''${!OUTPUT_NAMES[@]}"; do
            OUT_NAME="''${OUTPUT_NAMES[$i]}"
            RES="''${OUTPUT_RES[$i]:-1920x1080}"
            WIDTH=$(echo "$RES" | cut -d'x' -f1)
            HEIGHT=$(echo "$RES" | cut -d'x' -f2)

            SCALE_FACTOR=1
            if [ "$WIDTH" -ge 3000 ]; then
                SCALE_FACTOR=2
            fi

            PAD_X=$(( 48 * SCALE_FACTOR ))
            PAD_Y=$(( 48 * SCALE_FACTOR ))
            TITLE_PT=$(( 28 * SCALE_FACTOR ))
            META_PT=$(( 16 * SCALE_FACTOR ))
            GRAD_H=$(( 360 * SCALE_FACTOR ))

            TARGET_BASE="$CACHE_DIR/''${TODAY}-''${OUT_NAME}"
            TARGET_RAW="''${TARGET_BASE}-raw.jpg"
            TARGET_COMPOSED="''${TARGET_BASE}-composed.jpg"
            TARGET_INFO="''${TARGET_BASE}.json"
            CURRENT_COMPOSED="$CACHE_DIR/current-''${OUT_NAME}.jpg"
            CURRENT_INFO="$CACHE_DIR/current-''${OUT_NAME}.json"

            if [ "$FORCE" -eq 1 ] || [ "$RANDOM_PICK" -eq 1 ] || [ ! -f "$TARGET_COMPOSED" ]; then
                if [ "$TOTAL_COUNT" -gt 0 ]; then
                    if [ "$RANDOM_PICK" -eq 1 ]; then
                        SEED=$(echo "$RANDOM-''${OUT_NAME}-$(date +%s%N)" | cksum | awk '{print $1}')
                    else
                        SEED=$(echo "''${TODAY}-''${OUT_NAME}" | cksum | awk '{print $1}')
                    fi
                    INDEX=$(( SEED % TOTAL_COUNT ))

                    IMG_URL=""
                    ATTEMPTS=0
                    while [ -z "$IMG_URL" ] || [ "$IMG_URL" = "null" ]; do
                        OBJECT_ID=$(echo "$SEARCH_RESP" | jq -r ".objectIDs[$INDEX]")
                        OBJ_DATA=$(curl -s --max-time 10 "https://collectionapi.metmuseum.org/public/collection/v1/objects/$OBJECT_ID" || true)
                        IMG_URL=$(echo "$OBJ_DATA" | jq -r '.primaryImage // empty')

                        if [ -n "$IMG_URL" ]; then
                            break
                        fi

                        INDEX=$(( (INDEX + 1) % TOTAL_COUNT ))
                        ATTEMPTS=$(( ATTEMPTS + 1 ))
                        if [ "$ATTEMPTS" -ge 15 ]; then
                            break
                        fi
                    done

                    if [ -n "$IMG_URL" ]; then
                        TITLE=$(echo "$OBJ_DATA" | jq -r '.title // "Untitled"')
                        ARTIST=$(echo "$OBJ_DATA" | jq -r '.artistDisplayName // "Unknown Artist"')
                        DATE=$(echo "$OBJ_DATA" | jq -r '.objectDate // ""')
                        MUSEUM=$(echo "$OBJ_DATA" | jq -r '.department // "The Metropolitan Museum of Art"')

                        echo "Monitor $OUT_NAME: Downloading '$TITLE' by $ARTIST..."
                        if curl -s -L --max-time 60 "$IMG_URL" -o "$TARGET_RAW"; then
                            echo "$OBJ_DATA" > "$TARGET_INFO"

                            META_LINE="$ARTIST"
                            if [ -n "$DATE" ]; then
                                META_LINE="$ARTIST | $MUSEUM, $DATE"
                            else
                                META_LINE="$ARTIST | $MUSEUM"
                            fi

                            TITLE_ESC=$(echo "$TITLE" | sed 's/"/\\"/g')
                            META_ESC=$(echo "$META_LINE" | sed 's/"/\\"/g')

                            echo "Monitor $OUT_NAME: Rendering uncropped image at ''${WIDTH}x''${HEIGHT}..."
                            magick "$TARGET_RAW" \
                                -resize "''${WIDTH}x''${HEIGHT}" \
                                -background "#141617" \
                                -gravity center \
                                -extent "''${WIDTH}x''${HEIGHT}" \
                                \( -size "''${WIDTH}x''${GRAD_H}" gradient:none-"rgba(0,0,0,0.75)" -channel A -evaluate pow 2.2 +channel \) \
                                -gravity south -composite \
                                -gravity southwest \
                                -font "DejaVu-Sans-Bold" -pointsize "$TITLE_PT" \
                                -fill "rgba(0,0,0,0.8)" -annotate "+$(( PAD_X + 2 * SCALE_FACTOR ))+$(( PAD_Y + 30 * SCALE_FACTOR ))" "$TITLE_ESC" \
                                -fill "#ffffff" -annotate "+''${PAD_X}+$(( PAD_Y + 28 * SCALE_FACTOR ))" "$TITLE_ESC" \
                                -font "DejaVu-Sans" -pointsize "$META_PT" \
                                -fill "rgba(0,0,0,0.8)" -annotate "+$(( PAD_X + 2 * SCALE_FACTOR ))+$(( PAD_Y + 2 * SCALE_FACTOR ))" "$META_ESC" \
                                -fill "#e0e0e0" -annotate "+''${PAD_X}+''${PAD_Y}" "$META_ESC" \
                                "$TARGET_COMPOSED"
                        fi
                    fi
                fi
            fi

            if [ -f "$TARGET_COMPOSED" ]; then
                ln -sf "$TARGET_COMPOSED" "$CURRENT_COMPOSED"
                [ -f "$TARGET_INFO" ] && cp "$TARGET_INFO" "$CURRENT_INFO"

                echo "Monitor $OUT_NAME: Setting wallpaper via awww..."
                awww img -o "$OUT_NAME" "$CURRENT_COMPOSED" --transition-type fade --transition-duration 2 || true
            fi
        done

        # Cleanup old cache files
        find "$CACHE_DIR" -type f \( -name "*.jpg" -o -name "*.json" \) ! -name "current-*" -mtime +7 -delete 2>/dev/null || true
      '';
    in
    {
      home.packages = [
        pkgs.awww
        pkgs.imagemagick
        dailyArtScript
      ];

      systemd.user.services.awww-daemon = {
        Unit = {
          Description = "Awww Wayland Wallpaper Daemon";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.awww}/bin/awww-daemon";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

      systemd.user.services.daily-art-wallpaper = {
        Unit = {
          Description = "Daily Art Wallpaper Changer";
          After = [
            "graphical-session.target"
            "awww-daemon.service"
          ];
          Wants = [ "awww-daemon.service" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${dailyArtScript}/bin/daily-art-wallpaper";
        };
      };

      systemd.user.timers.daily-art-wallpaper = {
        Unit = {
          Description = "Change Art Wallpaper Daily at Midnight";
        };
        Timer = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "daily-art-wallpaper.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
}
