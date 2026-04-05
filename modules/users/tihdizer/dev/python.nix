{ ... }:
{
  flake.modules.homeManager.hm-tihdizer-dev-python =
    { pkgs, ... }:
    let
      python = pkgs.python314; # 3.14.2
    in
    {
      home.packages = with pkgs; [
        python

        # Linters/Formatters
        ruff # superset flake8/black
        black
        isort
        mypy # static types

        # Package managers
        poetry
        pipenv
        uv # fastest pip/ruff

        # LSP/Data
        datasette
      ];

      home.sessionVariables = {
        POETRY_HOME = "$HOME/.local/share/pypoetry";
        POETRY_CACHE_DIR = "$HOME/.cache/pypoetry";
        VIRTUAL_ENV_DISABLE_PROMPT = "1";
      };

      # LSP для helix/zed
      programs.helix.languages.python.language-server = "${pkgs.python-lsp-server}/bin/pylsp";
    };
}
