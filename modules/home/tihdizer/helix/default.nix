{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    helix # Rust code editor (like vim)
  ];
}
