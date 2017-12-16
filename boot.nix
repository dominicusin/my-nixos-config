{ config, lib, pkgs, ... }:
{

  boot = {
      consoleLogLevel = 7; #4
      vesa = true;
      tmpOnTmpfs = true;
      cleanTmpDir = true;
      extraTTYs = [ "tty8" "tty9" ];
      supportedFilesystems = [ "bcachefs" "btrfs" "cifs" "exfat" "ext" "f2fs" "glusterfs" "jfs" "nfs" "ntfs" "reiserfs" "unionfs-fuse" "vboxsf" "vfat" "xfs" "zfs" "hfsplus" ];
      kernelParams = [ "video=1920x1080" ];
      kernelModules = [ "snd-seq" "snd-rawmidi" "kvm-intel" "r8169" "snd_hda_intel" "exfat" "exfat-nofuse" "msr" "coretemp" ];
      blacklistedKernelModules = [ "snd_pcsp" "b43" "bcma" "bcma-pci-bridge" ];
      #kernelPackages = pkgs.linuxPackages_latest; #pkgs.linux_grsec_server_latest; # pkgs.linuxPackages_4_11; #pkgs.linuxPackages_4_4;
      #kernelPatches = [ pkgs.kernelPatches.ubuntu_fan_4_4 ];
      extraModulePackages = with config.boot.kernelPackages; [ sysdig ];
      kernel.sysctl = {
          "fs.inotify.max_user_watches"   = 1048576;   # default:  8192# 524288; # Note that inotify watches consume 1kB on 64-bit machines.
          "fs.inotify.max_user_instances" =    1024;   # default:   128
          "fs.inotify.max_queued_events"  =   32768;   # default: 16384
          "dev.cdrom.autoclose" = 0;
          "kernel.parameters.consoleblank" = 0;
          "kernel.pax.softmode" = 0;
          "kernel.perf_event_max_sample_rate" = 30000;
          "kernel.shmall" = 2097152;
          "kernel.shmmax" = 33554432;
          "kernel.sysrq" = 1;
          "net.core.rmem_max" = 50000000;
          "net.core.wmem_max" = 1048576;
          "net.ipv4.ip_forward" = 1;
          "net.ipv4.conf.all.accept_redirects" = 0;
          "net.ipv4.conf.all.send_redirects" = 0;
          "net.ipv4.conf.default.accept_redirects" = 0;
          "net.ipv4.conf.default.send_redirects" = 0;
          "net.ipv4.tcp_congestion_control" = "yeah";
          "net.ipv4.tcp_fastopen" = 1;
          "net.ipv4.tcp_slow_start_after_idle" = 0;
          "net.ipv6.conf.all.accept_redirects" = 0;
          "net.ipv6.conf.default.accept_redirects" = 0;
          "vm.swappiness" = 90;
          "vm.overcommit_memory" = 1;
      };
      initrd = {
          kernelModules = [ "fbcon" "ohci_hcd" "ehci_hcd" "pata_amd" "sata_nv" "usb_storage"  "kvm-intel" "tun" "virtio" ];
          availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "virtio_balloon" "virtio_blk" "virtio_pci" "virtio_ring" ];
      };
      loader = {
          systemd-boot.enable = true;
          timeout = 4;
          grub = {
              enable = true;
              version = 2; # Use the GRUB 2 boot loader.
              #efiSupport = true;
              #efiInstallAsRemovable = true;
              device = "nodev";   # "/dev/sda"; # or "nodev" for efi only # Define on which hard drive you want to install Grub.
              extraEntries = ''
                  if [ -f  ''${config_directory}/custom.cfg ]; then
                      source ''${config_directory}/custom.cfg
                 elif [ -z "''${config_directory}" -a -f  ''$prefix/custom.cfg ]; then
                      source ''$prefix/custom.cfg;
                 else
                      source custom.cfg;
                 fi
              '';
          };
          efi = {
              efiSysMountPoint = "/boot/efi";
              canTouchEfiVariables = true;
          };
      };
  };
}
