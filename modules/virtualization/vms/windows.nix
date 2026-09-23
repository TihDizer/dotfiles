{ ... }:
let
  vmName = "RDPWindows";
in
{
  flake.modules.nixos.windows =
    { pkgs, ... }:
    let
      domainXml = pkgs.writeText "${vmName}.xml" ''
        <domain type='kvm'>
          <name>${vmName}</name>
          <uuid>4faf0385-bd45-4f36-99e3-05b2a85d43da</uuid>
          <memory unit='KiB'>8388608</memory>
          <currentMemory unit='KiB'>4194304</currentMemory>
          <vcpu placement='static'>4</vcpu>
          <os firmware='efi'>
            <type arch='x86_64' machine='q35'>hvm</type>
            <boot dev='hd'/>
            <boot dev='cdrom'/>
          </os>
          <features>
            <acpi/>
            <apic/>
            <hyperv mode='custom'>
              <relaxed state='on'/>
              <vapic state='on'/>
              <spinlocks state='on' retries='8191'/>
              <vpindex state='on'/>
              <synic state='on'/>
              <stimer state='on'>
                <direct state='on'/>
              </stimer>
              <reset state='on'/>
              <frequencies state='on'/>
              <reenlightenment state='on'/>
              <tlbflush state='on'/>
              <ipi state='on'/>
            </hyperv>
            <vmport state='off'/>
            <smm state='on'/>
          </features>
          <cpu mode='host-passthrough' check='none' migratable='on'>
            <topology sockets='1' dies='1' clusters='1' cores='4' threads='1'/>
          </cpu>
          <clock offset='localtime'>
            <timer name='rtc' present='no' tickpolicy='catchup'/>
            <timer name='pit' present='no' tickpolicy='delay'/>
            <timer name='hpet' present='no'/>
            <timer name='kvmclock' present='no'/>
            <timer name='hypervclock' present='yes'/>
          </clock>
          <on_poweroff>destroy</on_poweroff>
          <on_reboot>restart</on_reboot>
          <on_crash>destroy</on_crash>
          <pm>
            <suspend-to-mem enabled='no'/>
            <suspend-to-disk enabled='no'/>
          </pm>
          <devices>
            <disk type='file' device='disk'>
              <driver name='qemu' type='qcow2' discard='unmap'/>
              <source file='/home/tihdizer/vms/ssd/${vmName}.qcow2'/>
              <target dev='vda' bus='virtio'/>
            </disk>
            <disk type='file' device='cdrom'>
              <driver name='qemu' type='raw'/>
              <target dev='sdb' bus='sata'/>
              <readonly/>
            </disk>
            <disk type='file' device='cdrom'>
              <driver name='qemu' type='raw'/>
              <source file='/home/tihdizer/vms/ssd/virtio-win.iso'/>
              <target dev='sdc' bus='sata'/>
              <readonly/>
            </disk>
            <controller type='usb' index='0' model='qemu-xhci'/>
            <controller type='sata' index='0'/>
            <controller type='virtio-serial' index='0'/>
            <interface type='network'>
              <source network='default'/>
              <model type='virtio'/>
            </interface>
            <channel type='spicevmc'>
              <target type='virtio' name='com.redhat.spice.0'/>
            </channel>
            <channel type='unix'>
              <source mode='bind'/>
              <target type='virtio' name='org.qemu.guest_agent.0'/>
            </channel>
            <input type='tablet' bus='usb'/>
            <input type='mouse' bus='ps2'/>
            <input type='keyboard' bus='ps2'/>
            <tpm model='tpm-crb'>
              <backend type='emulator' version='2.0'/>
            </tpm>
            <graphics type='spice' autoport='yes'>
              <listen type='address'/>
              <image compression='off'/>
            </graphics>
            <sound model='ich9'/>
            <audio id='1' type='spice'/>
            <video>
              <model type='qxl' ram='65536' vram='65536' vgamem='16384' heads='1' primary='yes'/>
            </video>
            <redirdev bus='usb' type='spicevmc'/>
            <memballoon model='virtio'/>
          </devices>
        </domain>
      '';
    in
    {
      systemd.services.windows-libvirt-vm = {
        description = "Define Windows libvirt virtual machine (${vmName})";
        after = [ "libvirtd.service" ];
        wants = [ "libvirtd.service" ];
        wantedBy = [ "multi-user.target" ];
        path = [
          pkgs.libvirt
          pkgs.qemu-utils
          pkgs.coreutils
          pkgs.gnugrep
          pkgs.gnused
        ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          mkdir -p /home/tihdizer/vms/ssd
          if [ ! -f /home/tihdizer/vms/ssd/${vmName}.qcow2 ]; then
            qemu-img create -f qcow2 /home/tihdizer/vms/ssd/${vmName}.qcow2 64G
          fi

          if virsh net-info default >/dev/null 2>&1; then
            virsh net-autostart default || true
            if ! virsh net-list | grep -q "default"; then
              virsh net-start default || true
            fi
          fi

          if ! virsh pool-info ssd >/dev/null 2>&1; then
            virsh pool-define-as ssd dir --target /home/tihdizer/vms/ssd || true
            virsh pool-autostart ssd || true
            virsh pool-start ssd || true
          fi

          if virsh dominfo "${vmName}" >/dev/null 2>&1; then
            EXISTING_UUID=$(virsh domuuid "${vmName}" 2>/dev/null || true)
            if [ -n "$EXISTING_UUID" ]; then
              TEMP_XML=$(mktemp)
              if grep -q "<uuid>" ${domainXml}; then
                sed "s|<uuid>.*</uuid>|<uuid>$EXISTING_UUID</uuid>|" ${domainXml} > "$TEMP_XML"
              else
                sed "s|<name>${vmName}</name>|<name>${vmName}</name>\n  <uuid>$EXISTING_UUID</uuid>|" ${domainXml} > "$TEMP_XML"
              fi
              virsh define "$TEMP_XML"
              rm -f "$TEMP_XML"
            else
              virsh define ${domainXml}
            fi
          else
            virsh define ${domainXml}
          fi
        '';
      };
    };
}
