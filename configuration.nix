# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.supportedFilesystems = [ "bcachefs" "btrfs" "cifs" "exfat" "ext" "f2fs" "glusterfs" "jfs" "nfs" "ntfs" "reiserfs" "unionfs-fuse" "vboxsf" "vfat" "xfs" "zfs" "hfsplus" ];
  boot.kernelParams = [    "video=1920x1080"  ];
  boot.kernelModules = [ "snd-seq" "snd-rawmidi"  "kvm-intel" "r8169" "snd_hda_intel" "exfat" "exfat-nofuse" ];
  boot.initrd.kernelModules = [ "fbcon" ];
  boot.cleanTmpDir = true;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.loader.grub.extraEntries = 
             ''


menuentry 'Windows Vista (на /dev/sda2)' --class windows --class os $menuentry_id_option 'osprober-chain-5AD0500FD04FEFB5' {
	savedefault
	insmod part_gpt
	insmod ntfs
	set root='hd0,gpt2'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt2 --hint-efi=hd0,gpt2 --hint-baremetal=ahci0,gpt2  5AD0500FD04FEFB5
	else
	  search --no-floppy --fs-uuid --set=root 5AD0500FD04FEFB5
	fi
	chainloader +1
}


menuentry 'Windows  (на /dev/sda2)' --class windows --class os $menuentry_id_option 'osprober-chain-5AD0500FD04FEFB5' {
		insmod part_gpt
		insmod ntfs
		insmod ntldr
		insmod search_fs_uuid
		insmod chain
		set root='hd0,gpt2'
		if [ x$feature_platform_search_hint = xy ]; then
		  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt2 --hint-efi=hd0,gpt2 --hint-baremetal=ahci0,gpt2 --hint='hd0,gpt2'  5AD0500FD04FEFB5
		else
		  search --no-floppy --fs-uuid --set=root 5AD0500FD04FEFB5
		fi
		ntldr /bootmgr
		#chainloader /EFI/Microsoft/Boot/bootmgfw.efi
		#chainloader /efi/boot/bootx64.efi.windows
		chainloader /EFI/Microsoft/Boot/bootmgfw.efi
		boot
}



           ''
;


  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };



  networking = {
      hostName = "absolon";
      hostId = "a8c0b902";
      networkmanager.enable = true;
      wireless.enable = false;
      enableIPv6 = true;

  };


  # Select internationalisation properties.
  i18n = {
     consoleFont = "cyr-sun16";
     consoleKeyMap = "ru";
     defaultLocale = "ru_RU.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Tiraspol";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget mc htop gpm tmux curl acpi
    binutils gcc gnumake pkgconfig git
    i3lock i3status
    unclutter rxvt_unicode
    qt5.qtbase

  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.acpid.enable = true;
  powerManagement.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us,ru(winkeys)";
  services.xserver.xkbModel="geniuscomfy2";
  services.xserver.xkbOptions = "grp:alt_shift_toggle,grp:win_switch,terminate:ctrl_alt_bksp,grp_led:scroll,altwin:menu";
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.autorun = true;
  hardware.opengl.driSupport32Bit = true;



  # Enable  Desktop Environment.
  services.xserver.desktopManager = {
    xfce.enable = true;
    gnome3.enable = true;
    plasma5.enable = true;
    default = "xfce";
  };

  services.xserver.windowManager = {
    xmonad.enable = true;
    twm.enable = true;
    icewm.enable = true;
    i3.enable = true;
  };

  services.gnome3.tracker.enable = false;

  services.compton = {
    enable          = true;
    fade            = true;
    inactiveOpacity = "0.9";
    shadow          = true;
    fadeDelta       = 4;
  };

  services.xserver.displayManager = {
    gdm.enable = false;
    gdm.autoLogin.enable = true;
    gdm.autoLogin.user = "domini";
    sddm.enable = false;
    sddm.autoLogin.enable = true;
    sddm.autoLogin.user = "domini";
    lightdm.enable = true;
    lightdm.autoLogin.enable = true;
    lightdm.autoLogin.user = "domini";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.domini = {
     name = "domini";
     isNormalUser = true;
     uid = 1000;
     description = "Domini Montessori";
     group = "users";
     extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"  "vboxuser" "docker" ];
     home = "/home/domini";
     createHome = true;
     useDefaultShell = true;
  };


  system.copySystemConfiguration = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-17.03;
  system.stateVersion = "17.03";

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 1h";


}
