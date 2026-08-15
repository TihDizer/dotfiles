{ ... }:
{
  flake.modules.homeManager.mpv =
    { pkgs, ... }:
    let
      mediaMimeTypes = [
        "video/mp4"
        "video/mkv"
        "video/x-matroska"
        "video/webm"
        "video/quicktime"
        "video/x-msvideo"
        "video/x-flv"
        "video/ogg"
        "video/x-ogm+ogg"
        "audio/mp3"
        "audio/mpeg"
        "audio/flac"
        "audio/ogg"
        "audio/wav"
        "audio/x-wav"
        "audio/aac"
        "audio/m4a"
      ];

      mimeAssociations = builtins.listToAttrs (
        map (mime: {
          name = mime;
          value = [ "mpv.desktop" ];
        }) mediaMimeTypes
      );
    in
    {
      programs.mpv = {
        enable = true;

        scripts = with pkgs.mpvScripts; [
          uosc
          thumbfast
          quality-menu
          mpris
          autoload
        ];

        config = {
          input-ipc-server = "/tmp/mpvsocket";
          save-position-on-quit = true;
          keep-open = true;

          osc = false;
          osd-bar = false;
          border = false;

          vo = "gpu-next";
          gpu-api = "vulkan";
          hwdec = "auto-safe";

          alang = "en,eng,ru,rus";
          slang = "pgs,en-pgs,sdh,en-sdh,eng-sdh,en,eng,en-forced,eng-forced,forced,ru,rus";

          sub-auto = "fuzzy";
          audio-file-auto = "fuzzy";

          sub-file-paths = "sub:subs:subtitles:Subtitles:Subs:Sub:srt:SRT:**";
          audio-file-paths = "audio:Audio:sound:tracks";

          ytdl-format = "bestvideo[height<=?2160]+bestaudio/best";
        };

        scriptOpts = {
          uosc = {
            timeline_style = "line";
            timeline_line_width = 3;
            timeline_size = 28;
            controls = "menu,gap,prev,play-pause,next,gap,subtitles,audio,video,playlist,fullscreen";
          };
          thumbfast = {
            hwdec = "auto-safe";
            network = true;
          };
        };

        bindings = {
          "space"      = "cycle pause; script-binding uosc/flash-pause-indicator";
          "MBTN_LEFT"  = "cycle pause; script-binding uosc/flash-pause-indicator";
          "tab"        = "script-binding uosc/toggle-ui";
          "m"          = "script-binding uosc/menu";
          "MBTN_RIGHT" = "script-binding uosc/menu";
          "s"          = "script-binding uosc/subtitles";
          "a"          = "script-binding uosc/audio";
          "c"          = "script-binding uosc/chapters";
          "p"          = "script-binding uosc/items";
          "q"          = "script-binding quality-menu/video_formats_toggle";
        };
      };

      xdg.mimeApps = {
        enable = true;
        defaultApplications = mimeAssociations;
      };

      home.packages = with pkgs; [
        ffmpeg
        yt-dlp
      ];
    };
}
