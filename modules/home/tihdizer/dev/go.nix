{ pkgs, ... }:

{
  # Go toolchain
  programs.go = {
    enable = true;
    env = {
      GOPRIVATE = "github.com:tihdizer";
      GOPATH = "$HOME/.local/go-work";
    };
  };

  # Go packages + tools
  home.packages = with pkgs; [
    go
    gcc

    # Tools
    gotools # gofmt gdoc
    gopls # LSP
    delve # debugger
    go-task # task runner
    goreleaser # releases

    # Utils
    gotip # latest Go
  ];

  # Shell hooks
  programs.bash.initExtra = ''
    export GOPATH=$HOME/.local/go-work
    export PATH=$GOPATH/bin:$PATH
  '';
}
