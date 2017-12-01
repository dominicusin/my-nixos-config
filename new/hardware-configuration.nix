# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a5ea1594-acb5-4e00-a5a4-d5d06e2072c3";
      fsType = "btrfs";
      options = [ "subvol=@nixos" ];
    };

  fileSystems."/tmp" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/mnt/mainboot" =
    { device = "/dev/disk/by-uuid/185e34fe-4a77-42a5-a7af-f8d1be061c68";
      fsType = "ext4";
    };

  fileSystems."/mnt/btrfs" =
    { device = "/dev/disk/by-uuid/a5ea1594-acb5-4e00-a5a4-d5d06e2072c3";
      fsType = "btrfs";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a5ea1594-acb5-4e00-a5a4-d5d06e2072c3";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/mnt/trueOS/mnt" =
    { device = "trueOS/ROOT/initial";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/tmp" =
    { device = "trueOS/tmp";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/usr/home" =
    { device = "trueOS/usr/home";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/usr/home/domini" =
    { device = "trueOS/usr/home/domini";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/usr/jails" =
    { device = "trueOS/usr/jails";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/usr/local/share/doc" =
    { device = "trueOS/usr/local/share/doc";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/usr/obj" =
    { device = "trueOS/usr/obj";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/usr/ports" =
    { device = "trueOS/usr/ports";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/usr/src" =
    { device = "trueOS/usr/src";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/var/audit" =
    { device = "trueOS/var/audit";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/var/log" =
    { device = "trueOS/var/log";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/var/mail" =
    { device = "trueOS/var/mail";
      fsType = "zfs";
    };

  fileSystems."/mnt/trueOS/var/tmp" =
    { device = "trueOS/var/tmp";
      fsType = "zfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/eba7360a-c0a0-4458-bffc-e401dfb86dc2"; }
    ];

  nix.maxJobs = lib.mkDefault 2;
}
