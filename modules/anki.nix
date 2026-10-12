{ ... }:
{
  flake.modules.homeManager.anki =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        anki
      ];

      xdg.dataFile."Anki2/addons21/online_audio/__init__.py".text = ''
        import os
        import urllib.parse
        import anki.template
        from anki.sound import SoundOrVideoTag
        import aqt.sound

        _orig_av_tag_to_native = anki.template.av_tag_to_native

        def _custom_av_tag_to_native(tag):
            val = tag.WhichOneof("value")
            if val == "sound_or_video":
                target = tag.sound_or_video
                if target.startswith(("http://", "https://")):
                    return SoundOrVideoTag(filename=target)
            return _orig_av_tag_to_native(tag)

        anki.template.av_tag_to_native = _custom_av_tag_to_native

        def _custom_av_tags_to_native(tags):
            return list(map(_custom_av_tag_to_native, tags))

        anki.template.av_tags_to_native = _custom_av_tags_to_native
        if hasattr(anki, "media") and hasattr(anki.media, "av_tags_to_native"):
            anki.media.av_tags_to_native = _custom_av_tags_to_native

        _orig_path = SoundOrVideoTag.path

        def _custom_path(self, media_folder: str) -> str:
            if self.filename.startswith(("http://", "https://")):
                return self.filename
            return _orig_path(self, media_folder)

        SoundOrVideoTag.path = _custom_path

        _orig_is_audio = aqt.sound.is_audio_file

        def _custom_is_audio(fname: str) -> bool:
            if fname.startswith(("http://", "https://")):
                parsed_path = urllib.parse.urlparse(fname).path
                return _orig_is_audio(parsed_path)
            return _orig_is_audio(fname)

        aqt.sound.is_audio_file = _custom_is_audio
      '';

      xdg.dataFile."Anki2/addons21/online_audio/manifest.json".text = builtins.toJSON {
        name = "Online Audio";
        package = "online_audio";
      };
    };
}
