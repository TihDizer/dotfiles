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

      # TODO: deduplicate
      environment.systemPackages = [
        pkgs.yazi
        pkgs.television
      ];

      programs.nvf = {
        enable = true;
        settings = {
          vim = {
            binds.whichKey.enable = true;

            utility.yazi-nvim = {
              enable = true;
            };

            extraPlugins = {
              tv-nvim = {
                package = pkgs.vimPlugins.tv-nvim;
                setup = "require('tv').setup {}";
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
                key = "<leader>ff";
                mode = "n";
                action = "<cmd>Tv files<cr>";
                desc = "Television Find Files";
              }
              {
                key = "<leader>fg";
                mode = "n";
                action = "<cmd>Tv git-repos<cr>";
                desc = "Television Git Repos";
              }
              {
                key = "<leader>fl";
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
