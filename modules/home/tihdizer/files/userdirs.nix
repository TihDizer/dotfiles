{
  config,
  lib,
  ...
}:

{
  xdg.userDirs = {
    enable = true;
    desktop = "";
    download = "$HOME/downloads";
    documents = "$HOME/documents";
    music = "$HOME/medias/music";
    pictures = "$HOME/medias/pictures";
    videos = "$HOME/medias/videos";
    templates = "$HOME/documents/templates";
    publicShare = "$HOME/shared";
  };

  home.activation.createMedias = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/medias/{music,pictures,videos}
    mkdir -p ~/documents/templates
  '';

  # home.file."downloads".source =
  #   config.lib.file.mkOutOfStoreSymlink "/hdd2/media/downloads";
}
