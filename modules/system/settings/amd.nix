{ ... }:
{
  flake.modules.nixos.amd =
    { config, pkgs, lib, ... }:
    {
      hardware.enableRedistributableFirmware = lib.mkDefault true;
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      boot.kernelModules = [
        "kvm-amd" # AMD Virtualization
        "k10temp" # Ryzen CPU Temperature Sensors
      ];

      boot.kernelParams = [
        "amdgpu.ppfeaturemask=0xffffffff"

        "pcie_aspm=off"
        "amdgpu.gpu_recovery=1"
        "amdgpu.lockup_timeout=10000"
        "amdgpu.runpm=0"
      ];

      services.udev.extraRules = ''
        SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0x731f", ATTR{power/control}="on"
      '';

      environment.systemPackages = with pkgs; [
        lact
      ];

      systemd.services.lact = {
        description = "AMDGPU Control Daemon";
        after = [ "multi-user.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.lact}/bin/lact daemon";
        };
        enable = true;
      };
    };
}
