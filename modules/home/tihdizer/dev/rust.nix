{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustc # compiler
    cargo # package manager

    # Tools
    rust-analyzer # LSP zed/helix
    rust-bindgen # C bindings
    cargo-edit # cadd cremove
    cargo-watch # auto-rebuild
  ];

  programs.bash.initExtra = ''
    export PATH="$HOME/.cargo/bin:$PATH"
  '';

  # LSP Helix
  programs.helix.languages.rust.language-server = "${pkgs.rust-analyzer}/bin/rust-analyzer";
}
