{ ... }:
{
  flake.modules.nixos.podman =
    { ... }:
    {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      virtualisation.containers.registries.settings.unqualified-search-registries = [ "docker.io" ];

      virtualisation.oci-containers.backend = "podman";
    };
}
