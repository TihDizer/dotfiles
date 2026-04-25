{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
  };

  flake.modules.nixos.nvf =
    { ... }:
    {
      imports = [
        inputs.nvf.nixosModule.default
      ];
      programs.nvf = {
        enable = true;
        settings = {
        };
      };
    };

  flake.modules.homeManager.example =
    { ... }:
    {
    };
}
