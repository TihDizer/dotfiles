{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
  };

  flake.modules.nixos.nvf =
    { pkgs, ... }:
    {
      imports = [
        inputs.nvf.nixosModules.default
      ];

      environment.systemPackages = with pkgs; [
        yazi
        television
        ripgrep
        fd
        lazygit
      ];

      programs.nvf = {
        enable = true;
        settings = {
          vim = {
            viAlias = true;
            vimAlias = true;
            preventJunkFiles = true;
            options = {
              tabstop = 2;
              shiftwidth = 2;
              expandtab = true;
              smartindent = true;
            };

            visuals = {
              nvim-web-devicons.enable = true;
              fidget-nvim.enable = true;
            };

            statusline.lualine = {
              enable = true;
            };

            binds.whichKey.enable = true;

            utility.yazi-nvim = {
              enable = true;
            };

            terminal.toggleterm = {
              enable = true;
              setupOpts = {
                direction = "float";
                open_mapping = "[[<C-t>]]";
              };
            };

            git.gitsigns = {
              enable = true;
              codeActions.enable = true;
            };

            languages = {
              enableTreesitter = true;
              enableExtraDiagnostics = true;

              nix.enable = true;
              python.enable = true;
              rust.enable = true;
              terraform.enable = true;
              yaml.enable = true;
              toml.enable = true;
            };

            lsp = {
              enable = true;
            };

            autocomplete.nvim-cmp = {
              enable = true;
            };

            extraPlugins = {
              tv-nvim = {
                package = pkgs.vimPlugins.tv-nvim;
                setup = "require('tv').setup {}";
              };
              smear-cursor = {
                package = pkgs.vimPlugins.smear-cursor-nvim;
                setup = "require('smear_cursor').setup {}";
              };
              mini-files = {
                package = pkgs.vimPlugins.mini-nvim;
                setup = ''
                  local mf = require('mini.files')
                  mf.setup({
                    windows = {
                      preview = true,
                    },
                  })
                '';
              };
              lazygit = {
                package = pkgs.vimPlugins.lazygit-nvim;
                setup = "";
              };
            };

            keymaps = [
              {
                key = "<leader>y";
                mode = "n";
                action = "<cmd>Yazi<cr>";
                desc = "Open Yazi File Manager";
              }
              {
                key = "<leader>e";
                mode = "n";
                action = "<cmd>lua if not MiniFiles.close() then MiniFiles.open() end<cr>";
                desc = "Toggle Fast Project View (MiniFiles)";
              }
              {
                key = "<leader>tf";
                mode = "n";
                action = "<cmd>Tv files<cr>";
                desc = "Television Find Files";
              }
              {
                key = "<leader>tt";
                mode = "n";
                action = "<cmd>Tv text<cr>";
                desc = "Television Live Grep (Text Search)";
              }
              {
                key = "<leader>g";
                mode = "n";
                action = "<cmd>LazyGit<cr>";
                desc = "Open LazyGit Panel";
              }
            ];
          };
        };
      };
    };

  flake.modules.homeManager.example =
    { ... }:
    {
    };
}
