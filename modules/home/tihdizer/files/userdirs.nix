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
    mkdir -p ~/shared{storage,medias}
    mkdir -p ~/projects
    mkdir -p ~/dotfiles
    mkdir -p ~/notes ~/vms
    mkdir -p ~/games{nvme,hdd}
    mkdir -p ~/mnt/{usbs,nvme,storage,medias}
  '';

  home.file."mnt/storage".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd1/tihdizer";
  home.file."downloads".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd1/tihdizer/downloads";
  home.file."notes".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd1/tihdizer/notes";
  home.file."documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd1/tihdizer/documents";
  home.file."shared/storage".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd1/shared";

  home.file."mnt/medias".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd2/tihdizer";
  home.file."medias".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd2/tihdizer/medias";
  home.file."games/hdd".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd2/tihdizer/games";
  home.file."shared/medias".source = config.lib.file.mkOutOfStoreSymlink "/mnt/hdd2/shared";

  home.file."mnt/nvme".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nvme/tihdizer";
  home.file."vms/nvme".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nvme/tihdizer/vms";
  home.file."games/nvme".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nvme/tihdizer/games";
  home.file."projects".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nvme/tihdizer/projects";
}
