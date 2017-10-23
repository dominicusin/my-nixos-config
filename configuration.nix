# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#{ config, pkgs, ... }:

{ config, lib, pkgs, ... }:

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
  boot.kernelParams = [ "video=1920x1080" ];
  boot.kernelModules = [ "snd-seq" "snd-rawmidi"  "kvm-intel" "r8169" "snd_hda_intel" "exfat" "exfat-nofuse" "msr" "coretemp"  ];
  boot.kernelPatches = [ pkgs.kernelPatches.ubuntu_fan_4_4 ];
  boot.kernelPackages = pkgs.linuxPackages_4_4;
  boot.blacklistedKernelModules = [ "snd_pcsp" "b43" "bcma" "bcma-pci-bridge" ];
  boot.initrd.kernelModules = [ "fbcon" "ohci_hcd" "ehci_hcd" "pata_amd" "sata_nv" "usb_storage" ];
  boot.cleanTmpDir = true;
  # Define on which hard drive you want to install Grub.
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 4;
  boot.loader.grub.device = "nodev";   # "/dev/sda"; # or "nodev" for efi only
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
      # Note that inotify watches consume 1kB on 64-bit machines.
      "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
      "fs.inotify.max_user_instances" =    1024;   # default:   128
      "fs.inotify.max_queued_events"  =   32768;   # default: 16384
  };
  boot.loader.grub.extraEntries = 
             ''
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
		chainloader /EFI/Microsoft/Boot/bootmgfw.efi
		#chainloader /efi/boot/bootx64.efi.windows
		boot
		chainloader +1
}

           ''
;


  nixpkgs.config.pulseaudio = true;



  networking = {
      hostName = "absolon";
      hostId = "a8c0b902";
      networkmanager.enable = lib.mkForce true;
      networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
      nameservers = [ "8.8.8.8" "8.8.4.4" ];
      wireless.enable = lib.mkForce false;
      enableIPv6 = true;
      enableIntel3945ABGFirmware = true;
      enableIntel2200BGFirmware = true;
     # Open ports in the firewall.
     # networking.firewall.allowedTCPPorts = [ ... ];
     # networking.firewall.allowedUDPPorts = [ ... ];
     # Or disable the firewall altogether.
     firewall.enable = false;
  };


  # Select internationalisation properties.
  i18n = {
     consoleFont = "cyr-sun16";
     consoleKeyMap = "ru";
     defaultLocale = "ru_RU.UTF-8";
     #consoleUseXkbConfig = true;
  };


  # Set your time zone.
  time.timeZone = "Europe/Tiraspol";

  fonts.enableCoreFonts = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "devicemapper";

  hardware = {
      enableRedistributableFirmware = true;
      cpu.intel.updateMicrocode = true;
      cpu.amd.updateMicrocode = false;
      facetimehd.enable = true;
      opengl.enable = true;
      opengl.driSupport32Bit = true;
      opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      pulseaudio = {
            enable = true;
            package = pkgs.pulseaudioFull;
            support32Bit = true;
            daemon.config = {
                 flat-volumes = "no";
            };
      };
      bluetooth.enable = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget mc htop gpm tmux curl acpi    binutils gcc gnumake pkgconfig git
    python36Full    i3lock i3status    unclutter rxvt_unicode    qt5.qtbase
    abduco abiword anki arandr asciinema aws-auth awscli bazaar bind binutils blueman bmon bridge-utils clac cmus cnijfilter2 compton ctags cups-bjnp cvs cvs_fast_export darcs deluge desktop_file_utils dhcp dhcpcd
    di dmenu2 dnsmasq dropbox dunst dvtm emacs evince exa exiv2 ezstream file firefoxWrapper fuse fzf gimp git git-series glib global glxinfo gnome3 gnupg21 google-chrome gpick graphviz gtk2 gtypist haskellPackages
    hdparm hicolor_icon_theme hipchat hotspot hplip htop idea iftop inkscape iomelt iptables irssi isync iw jdk jnettop jq lcdproc leiningen libreoffice libsysfs libva lr lsof lxc lynx man-pages mc mercurialFull
    mkpasswd mongodb-tools mosh mpv msmtp mtr ncdu ncurses neomutt networkmanagerapplet nix-index nix-prefetch-scripts nix-repl nmap notmuch nq nssTools openocd openssl openvswitch pagemon pass pavucontrol pciutils
    peco pinentry playerctl powertop psmisc python2Full python2Packages pythonPackages qdirstat ranger reptyr ripgrep rofi rpm rtags rxvt_unicode_with-plugins scrot shared_mime_info silver-searcher skype socat spotify
    sshfsFuse sshpass stalonetray stunnel sublime3 subversion sxhkd sxiv taffybar tango-icon-theme taskwarrior termite texstudio tmux torbrowser tree tweak unzip urlview usbutils vanilla-dmz vdpauinfo vifm vimHuge vis
    vmtouch vnstat w3m-full watchman weechat wget wiggle winetricks wineUnstable wmctrl xautolock xclip xe xidel xlsfonts xorg xsel xss-lock xsv zathura zip zoom-us zsh
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


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

  nix.binaryCaches = [ http://cache.nixos.org http://hydra.nixos.org ];
  nix.maxJobs = 4;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 1h";


}

