{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

      environment.sessionVariables = {
        EDITOR = "vim";
        VISUAL = "vim";
      };

      programs.nvf = {
        enable = true;
        settings = {
          vim = {
            viAlias = true;
            vimAlias = true;
            preventJunkFiles = true;
            debugMode = {
              enable = false;
              level = 16;
              logFile = "/tmp/nvim.log";
            };
            clipboard = {
              enable = true;
              registers = "unnamedplus";
            };
            options = {
              tabstop = 2;
              shiftwidth = 2;
              expandtab = true;
              smartindent = true;
              scrolloff = 5;
            };

            spellcheck = {
              enable = true;
            };

            lsp = {
              enable = true;

              formatOnSave = true;
              lspkind.enable = false;
              lightbulb.enable = true;
              lspsaga.enable = false;
              trouble.enable = true;
              lspSignature.enable = false;
              otter-nvim.enable = true;
              nvim-docs-view.enable = true;
              presets.harper.enable = true;
            };

            debugger = {
              nvim-dap = {
                enable = true;
                ui.enable = true;
              };
            };

            languages = {
              enableTreesitter = true;
              enableExtraDiagnostics = true;

              nix = {
                enable = true;
                format.enable = true;
                lsp = {
                  enable = true;
                  servers = [ "nixd" ];
                };
              };
              markdown.enable = true;
              bash.enable = true;
              rust = {
                enable = true;
                extensions.crates-nvim.enable = true;
              };
              terraform.enable = true;
              yaml.enable = true;
              toml.enable = true;
              json.enable = true;
              sql.enable = true;
              docker.enable = true;
              env.enable = true;

              tex.enable = true;
              go.enable = true;
              lua.enable = true;
              python.enable = true;
              css.enable = true;
              scss.enable = true;
              html.enable = true;
            };

            visuals = {
              nvim-scrollbar.enable = true;
              nvim-web-devicons.enable = true;
              nvim-cursorline.enable = true;
              cinnamon-nvim.enable = true;
              fidget-nvim.enable = true;

              highlight-undo.enable = true;
              blink-indent.enable = true;
              indent-blankline.enable = true;
            };

            statusline.lualine = {
              enable = true;
            };

            autopairs.nvim-autopairs.enable = true;

            autocomplete = {
              nvim-cmp.enable = false;
              blink-cmp.enable = true;
            };

            snippets.luasnip.enable = true;

            tabline = {
              nvimBufferline.enable = true;
            };

            treesitter.context.enable = true;

            binds = {
              whichKey.enable = true;
              cheatsheet.enable = true;
            };

            git = {
              enable = true;
              gitsigns.enable = true;
              gitsigns.codeActions.enable = false;
              neogit.enable = true;
            };

            dashboard = {
              dashboard-nvim.enable = false;
              alpha.enable = true;
            };

            notify = {
              nvim-notify.enable = true;
            };

            projects = {
              project-nvim.enable = true;
            };

            utility = {
              ccc.enable = false;
              vim-wakatime.enable = false;
              diffview-nvim.enable = true;
              yanky-nvim.enable = false;
              qmk-nvim.enable = false;
              surround.enable = true;
              multicursors.enable = true;
              smart-splits.enable = true;
              undotree.enable = true;
              nvim-biscuits.enable = true;
              grug-far-nvim.enable = true;

              motion = {
                hop.enable = true;
                leap.enable = true;
                precognition.enable = true;
              };
              images = {
                image-nvim.enable = false;
                img-clip.enable = true;
              };
            };

            notes = {
              neorg.enable = false;
              orgmode.enable = false;
              todo-comments.enable = true;
            };

            terminal = {
              toggleterm = {
                enable = true;
                lazygit.enable = true;
              };
            };

            ui = {
              borders.enable = true;
              noice.enable = true;
              colorizer.enable = true;
              illuminate.enable = true;
              breadcrumbs = {
                enable = true;
                navbuddy.enable = true;
              };
              smartcolumn = {
                enable = true;
                setupOpts.custom_colorcolumn = {
                  # this is a freeform module, it's `buftype = int;` for configuring column position
                  nix = "110";
                  ruby = "120";
                  java = "130";
                  go = [
                    "90"
                    "130"
                  ];
                };
              };
              fastaction.enable = true;
            };

            session = {
              nvim-session-manager.enable = false;
            };

            gestures = {
              gesture-nvim.enable = false;
            };

            comments = {
              comment-nvim.enable = true;
            };

            presence = {
              neocord.enable = false;
            };

            utility.yazi-nvim = {
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
