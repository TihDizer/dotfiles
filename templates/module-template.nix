{ ... }:
{
  # Optional inputs for this module.
  flake-file.inputs = {
    # example.url = "github:owner/repo";
  };

  # NixOS module template (rename "example" as needed).
  flake.modules.nixos.example =
    { ... }:
    {
      # Module body
    };

  # Home Manager module template (rename "example" as needed).
  flake.modules.homeManager.example =
    { ... }:
    {
      # Module body
    };
}
