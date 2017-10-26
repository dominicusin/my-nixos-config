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
  # Define on which hard drive you want to install Grub.
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 4;
  boot.loader.grub.device = "nodev";   # "/dev/sda"; # or "nodev" for efi only
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.extraEntries =
	''
		if [ -f  ''${config_directory}/custom.cfg ]; then
		  source ''${config_directory}/custom.cfg
		elif [ -z "''${config_directory}" -a -f  ''$prefix/custom.cfg ]; then
		  source ''$prefix/custom.cfg;
		else
		  source custom.cfg;
		fi
	''
;

  boot.supportedFilesystems = [ "bcachefs" "btrfs" "cifs" "exfat" "ext" "f2fs" "glusterfs" "jfs" "nfs" "ntfs" "reiserfs" "unionfs-fuse" "vboxsf" "vfat" "xfs" "zfs" "hfsplus" ];
  boot.kernelParams = [ "video=1920x1080" ];
  boot.kernelModules = [ "snd-seq" "snd-rawmidi"  "kvm-intel" "r8169" "snd_hda_intel" "exfat" "exfat-nofuse" "msr" "coretemp"  ];
  #boot.kernelPatches = [ pkgs.kernelPatches.ubuntu_fan_4_4 ];
  #boot.kernelPackages = pkgs.linuxPackages_4_4;
  boot.blacklistedKernelModules = [ "snd_pcsp" "b43" "bcma" "bcma-pci-bridge" ];
  boot.initrd.kernelModules = [ "fbcon" "ohci_hcd" "ehci_hcd" "pata_amd" "sata_nv" "usb_storage" ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "virtio_balloon" "virtio_blk" "virtio_pci" "virtio_ring" ];
  boot.cleanTmpDir = true;
  boot.kernel.sysctl = {
      # Note that inotify watches consume 1kB on 64-bit machines.
	"fs.inotify.max_user_watches"   = 1048576;   # default:  8192
	"fs.inotify.max_user_instances" =    1024;   # default:   128
	"fs.inotify.max_queued_events"  =   32768;   # default: 16384
	"dev.cdrom.autoclose" = 0;
	"kernel.parameters.consoleblank" = 0;
	"kernel.pax.softmode" = 0;
	"kernel.perf_event_max_sample_rate" = 30000;
#	"kernel.printk" = "1 1 1 1";
	"kernel.shmall" = 2097152;
	"kernel.shmmax" = 33554432;
	"kernel.sysrq" = 1;
	"net.core.rmem_max" = 50000000;
	"net.core.wmem_max" = 1048576;
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
  };




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
  virtualisation.libvirtd.enable = true;

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.sudo.configFile="
	root    ALL=(ALL) ALL
	domini  ALL=(ALL)    NOPASSWD: ALL
  ";

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

  environment.systemPackages = with pkgs; [
    abduco abiword acpi anki arandr asciinema aws-auth awscli bazaar bind binutils blueman bmon bridge-utils cmus cnijfilter2 compton ctags cups-bjnp curl cvs cvs_fast_export darcs deluge desktop_file_utils
    dhcp dhcpcd di dmenu2 debootstrap dnsmasq dropbox dunst dvtm emacs evince exiv2 file firefoxWrapper fuse fzf gcc gimp git glib glxinfo global gnumake gnupg google-chrome gpm graphviz gtk2 gtypist
    hdparm hicolor_icon_theme hipchat hplip rpm-ostree htop i3lock i3status 
    #idea 
    iftop inkscape iomelt iptables 
    #irssi isync iw jdk jnettop jq leiningen libreoffice libsysfs libva lr lsof lxc lynx man-pages mc mercurialFull 
#    mkpasswd mongodb-tools mosh mpv msmtp mtr ncdu ncurses neomutt networkmanagerapplet nix-prefetch-scripts nix-repl nmap notmuch nq nssTools openocd openssl openvswitch pagemon pass pavucontrol pciutils peco 
#    pinentry pkgconfig playerctl powertop psmisc python2Full python2Packages python36Full pythonPackages qt5.qtbase ranger reptyr ripgrep rofi rpm rtags rxvt_unicode rxvt_unicode_with-plugins scrot 
#    shared_mime_info silver-searcher skype socat sshfsFuse sshpass stalonetray stunnel sublime3 subversion sxhkd sxiv taffybar tango-icon-theme taskwarrior termite texstudio tmux torbrowser tree tweak 
#    unclutter unzip urlview usbutils vanilla-dmz vdpauinfo vifm vis vmtouch vnstat w3m-full watchman weechat wget winetricks wineUnstable wmctrl xautolock xclip xe xidel xlsfonts xorg xsel xss-lock 
    zathura zip zsh
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
     #openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... alice@foobar" ];
  };



  system.copySystemConfiguration = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.autoUpgrade.enable = true;
#  system.autoUpgrade.channel = https://nixos.org/channels/nixos-17.03;
#  system.stateVersion = "17.03";
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-17.09;
  system.stateVersion = "17.09";
#  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;
#  system.stateVersion = "unstable";

  nixpkgs.config.allowBroken = false;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;

  nix.binaryCaches = [ http://cache.nixos.org http://hydra.nixos.org ];
  nix.maxJobs = 4;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 1h";


}


