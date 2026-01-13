{ config, pkgs, ... }:

{
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];

  # Libvirt/VMs
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  # Spice USB (VM access)
  security.wrappers.spice-client-glib-usb-acl-helper = {
    source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
    owner = "root";
    group = "root";
    setuid = true;
  };

  environment.systemPackages = with pkgs; [
    # Hardware/VM
    spice-gtk # Spice VM client
  ];
}
