{ ... }:
{
  flake.modules.nixos.amd =
    { config, pkgs, lib, ... }:
    {
      hardware.enableRedistributableFirmware = lib.mkDefault true;
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      boot.kernelModules = [
        "kvm-amd" # AMD Virtualization
        "amdgpu"  # Radeon RX dGPU + iGPU
        "k10temp" # Ryzen CPU Temperature Sensors
      ];

      boot.kernelParams = [
        "amdgpu.ppfeaturemask=0xffffffff"
        "amdgpu.force_performance_level=high"

        "pcie_aspm=off"
        "amdgpu.gpu_recovery=1"
        "amdgpu.lockup_timeout=10000"
      ];

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
