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

  home.activation.createDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/medias/{music,pictures,videos}
    mkdir -p ~/downloads/{git,}
    mkdir -p ~/documents/templates
    mkdir -p ~/shared
    mkdir -p ~/projects
    mkdir -p ~/notes ~/vms ~/.mnt/{usbs,}
  '';

  # home.file."downloads".source =
  #   config.lib.file.mkOutOfStoreSymlink "/hdd2/media/downloads";
}
