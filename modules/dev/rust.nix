{ ... }:
{
  flake.modules.homeManager.rust =
    { lib, pkgs, ... }:
    let
      rustToolchain = (
        pkgs.rust-bin.stable.latest.default.override {
          extensions = [
            "rust-src"
            "clippy"
            "rustfmt"
            "rust-analyzer"
          ];
        }
      );
    in
    {
      home.packages = with pkgs; [
        rustToolchain
        openssl
        pkg-config
        rust-bindgen
        cargo-edit
        cargo-watch
        jetbrains.rust-rover
      ];

      home.activation.rustRoverSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p ~/.rust-rover/toolchain
        ln -sfn ${rustToolchain}/lib/rustlib/x86_64-unknown-linux-gnu/lib ~/.rust-rover/toolchain/lib
        ln -sfn ${rustToolchain}/bin ~/.rust-rover/toolchain/bin
      '';

      home.sessionVariables = {
        RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
      };

      home.sessionPath = [
        "$HOME/.cargo/bin"
      ];
    };
}
