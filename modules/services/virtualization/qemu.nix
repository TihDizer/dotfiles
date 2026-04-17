{ ... }:
{
  flake.modules.nixos.services-virtualization-qemu =
    { pkgs, ... }:
    {
      boot.binfmt.emulatedSystems = [
        "aarch64-linux"
        "riscv64-linux"
      ];

      programs.virt-manager.enable = true;
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
        };
      };

      security.wrappers.spice-client-glib-usb-acl-helper = {
        source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
        owner = "root";
        group = "root";
        setuid = true;
      };

      environment.systemPackages = with pkgs; [
        spice-gtk # Spice VM client
      ];
    };
}
