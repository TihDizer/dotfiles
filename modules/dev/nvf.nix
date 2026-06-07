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

      environment.systemPackages = [
        pkgs.yazi
        pkgs.television
        pkgs.ripgrep
        pkgs.fd
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
                      preview = true,      -- Turns on the live file preview panel
                      width_focus = 30,    -- Width of the active folder column
                      width_preview = 80,  -- Width of the file preview window
                    },
                  })
                '';
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
