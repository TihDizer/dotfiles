{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zed-editor # Rust code editor
  ];
}
