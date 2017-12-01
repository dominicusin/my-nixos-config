{ config, lib, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    require =   [     ./mount.nix    ];

  # Use the GRUB 2 boot loader.
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
              version = 2;
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

  networking = {
      hostName = "absolon";
      hostId = "a8c0b902";
      networkmanager.enable = lib.mkForce true;
      networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
      nameservers = [ "8.8.8.8" "8.8.4.4" ];
      timeServers = [ "178.17.160.12" "194.54.161.214" "212.59.0.2" "31.131.0.254" "80.96.120.251" "80.96.120.253" ];
      wireless.enable = lib.mkForce false;
      enableIPv6 = true;
      firewall = {
         enable = false;
         allowPing = true;
         #allowedTCPPorts = [ ... ];
         #allowedUDPPorts = [ ... ];
      };
  };


  # Select internationalisation properties.
  i18n = {
     consoleFont = "cyr-sun16";
     consoleKeyMap = "ru";
     defaultLocale = "ru_RU.UTF-8";
     consoleUseXkbConfig = false;
  };


  # Set your time zone.
  time.timeZone = "Europe/Tiraspol";

  fonts = {
    enableFontDir = true;
    enableCoreFonts = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      fantasque-sans-mono
      inconsolata
      unifont
      ubuntu_font_family
      noto-fonts
      symbola
    ];
  };
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "devicemapper";
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = false;
  #virtualisation.virtualbox.host.enableHardening = true;

  security.sudo.enable = true;
  security.chromiumSuidSandbox.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.sudo.configFile="
       root    ALL=(ALL) ALL
       domini  ALL=(ALL) NOPASSWD: ALL
  ";
  security.pam.loginLimits = [
      { domain = "root"; type = "-"; item = "memlock"; value = "unlimited"; }
      { domain = "*"; type = "soft"; item = "nproc"; value = "65000"; }
      { domain = "*"; type = "hard"; item = "nproc"; value = "1000000"; }
      { domain = "*"; type = "-"; item = "nofile"; value = "1048576"; }
      { domain = "*"; item = "nofile"; type = "-"; value = "999999"; }
      { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
      { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
      { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
      { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  hardware = {
      enableRedistributableFirmware = true;
      cpu.intel.updateMicrocode = true;
      cpu.amd.updateMicrocode = false;
      facetimehd.enable = true;
      opengl.enable = true;
      opengl.driSupport = true;
      opengl.driSupport32Bit = true;
      opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      bluetooth.enable = true;
      sane = {
          enable = true;
          extraBackends = [ pkgs.hplipWithPlugin ];
      };
      pulseaudio = {
            enable = true;
            package = pkgs.pulseaudioFull.override { jackaudioSupport = true; };
            support32Bit = true;
            daemon.config = {
                 flat-volumes = "no";
            };
      };
  };

  programs = {
      adb.enable = true;
      bash = {
         enableCompletion = true;
         interactiveShellInit = ''
                HISTCONTROL=ignoreboth:erasedups
                shopt -s histappend
         '';
         promptInit = ''
                PS1="\[\033[1;32m\][\u@\h:\w]\$ "
         '';
         shellAliases = { ssh = "TERM=xterm-256color ssh"; };
      };
      bcc.enable = true;
      browserpass.enable = true;
      cdemu.enable = true;
      chromium.enable = true;
      command-not-found.enable = true;
      fish.enable = true;
      fish.vendor.completions.enable = true;
      fish.vendor.config.enable = true;
      fish.vendor.functions.enable = true;
      ssh.startAgent = false;
      gnupg = {
          dirmngr.enable = true;
          agent = {
              enable = true;
              enableSSHSupport = true;
              enableBrowserSocket = true;
              enableExtraSocket = true;
          };
      };
      gphoto2.enable = true;
      info.enable = true;
      java.enable = true;
      kbdlight.enable = true;
      light.enable = true;
      man.enable = true;
      mosh.enable = true;
      mtr.enable = true;
      npm.enable = true;
      oblogout.enable = true;
      qt5ct.enable = true;
      slock.enable = true;
      spacefm.enable = true;
      sway.enable = true;
      sysdig.enable = true;
      thefuck.enable = true;
      tmux.enable = true;
      wireshark.enable = true;
      #xonsh.enable = true;
      zsh.enable = true;
      zsh.enableAutosuggestions = true;
      zsh.enableCompletion = true;
      zsh.ohMyZsh.enable = true;
      zsh.syntaxHighlighting.enable = true;
  };

  environment= {
      systemPackages = import ./packages.nix pkgs;
      variables = {
              TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
              ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
              EDITOR = pkgs.lib.mkOverride 0  "emacsclient -c";
              BROWSER = pkgs.lib.mkOverride 0 "firefox";
              DISPLAY = ":${toString config.services.xserver.display}";
      };
      etc = {
          gitconfig.text = ''
               [user]
                  email = transgregorial@gmail.com
                  name = Domini Montessori
               [pull]
                  rebase = true
               [color]
                  ui = auto
               [push]
                  default = simple
               [merge]
                  conflictstyle = diff3
         '';
         "stack/config.yaml".text = ''
                  templates:
                     params:
                        author-email: transgregorial@gmail.com
                        author-name: Domini Montessori
                        github-username: dominicusin
                     nix::
                        enable: true
         '';
    };
  };



  powerManagement = {
     enable = true;
     cpuFreqGovernor = "performance";
  };


  services = {  # List services that you want to enable:
    openssh.enable = true;  # Enable the OpenSSH daemon.
    nixosManual.showManual = true;
    gpm.enable = true;
    kbfs.enable = true;
    acpid.enable = true;
    dnsmasq.enable = false;
    gnome3.tracker.enable = false;
    mpd = {
          enable = true;
          user = "domini";
          group = "users";
          musicDirectory = "/home/domini/Music";
          dataDir = "/home/domini/.mpd";
          extraConfig = ''
              audio_output {
                    type    "pulse"
                    name    "Local MPD"
                    server  "127.0.0.1"
              }
      '';
    };
    redis =   {
          enable = true;
          unixSocket = "/tmp/redis.sock";
    };
    syncthing = {
        enable = true;
        useInotify = true;
        user = "domini";
        dataDir = "/home/domini/.syncthing";
        openDefaultPorts = true;
    };
    printing = {
        enable = true; # Enable CUPS to print documents.
        drivers = [ pkgs.hplipWithPlugin ];
    };
    xserver = {   # Enable the X11 windowing system.
       enable = true;
       autorun = true;
       layout = "us,ru(winkeys)";
       enableCtrlAltBackspace = true;
       libinput.enable = true;
       xkbModel="geniuscomfy2";
       xkbOptions = "grp:alt_shift_toggle,grp:win_switch,terminate:ctrl_alt_bksp,grp_led:scroll,altwin:menu";
       videoDrivers = [ "intel" ];
       desktopManager = {   # Enable  Desktop Environment.
          #slim.enable = false;
          enlightenment.enable = true; #e19.enable = true;
          #gnome3.debug
          gnome3.enable = true;
          #gnome3.extraGSettingsOverridePack
          #gnome3.extraGSettingsOverrides
          #gnome3.sessionPath
          #kde5 = true;
          kodi.enable = true; #xbmc
          #lumina.enable = true;
          lxqt.enable = true;
          mate.enable = true;
          maxx.enable = true;
          plasma5.enable = true;
          plasma5.enableQt4Support = true;
          #wallpaper.combineScreens
          #wallpaper.mode
          xfce.enable = true;
          xfce.enableXfwm = true;
          #xfce.extraSessionCommands
          #xfce.noDesktop
          #xfce.screenLock
          xfce.thunarPlugins = [ pkgs.xfce.thunar-archive-plugin pkgs.xfce.thunar_volman ];
          xterm.enable = false;
          default = "xfce";
       };
      displayManager = {
          gdm.enable = false; gdm.autoLogin.enable = true; gdm.autoLogin.user = "domini";
          sddm.enable = false; sddm.autoLogin.enable = true; sddm.autoLogin.user = "domini";
          lightdm.enable = true; lightdm.autoLogin.enable = true; lightdm.autoLogin.user = "domini";
          sessionCommands = ''
              export GTK_PATH=${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0 # Set GTK_PATH so that GTK+ can find the Xfce theme engine.
              export GTK_DATA_PREFIX=${config.system.path} # Set GTK_DATA_PREFIX so that GTK+ can find the Xfce themes.
              export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules # Set GIO_EXTRA_MODULES so that gvfs works.
              ${pkgs.xfce.xfce4settings}/bin/xfsettingsd & # Launch xfce settings daemon.
              ${pkgs.networkmanagerapplet}/bin/nm-applet & # Network Manager Applet
        '';

       };
       windowManager = {
	  afterstep.enable = true;
	  awesome.enable = true;
	  bspwm.enable = true;
	  dwm.enable = true;
	  exwm.enable = true;
	  exwm.enableDefaultConfig = true;
	  fluxbox.enable = true;
	  fvwm.enable = true;
	  herbstluftwm.enable = true;
	  i3.enable = true;
	  icewm.enable = true;
	  jwm.enable = true;
	  #metacity.enable = true;
	  mwm.enable = true;
	  notion.enable = true;
	  openbox.enable = true;
	  pekwm.enable = true;
	  qtile.enable = true;
	  ratpoison.enable = true;
	  sawfish.enable = true;
	  spectrwm.enable = true;
	  #stumpwm.enable = true;
	  twm.enable = true;
	  windowlab.enable = true;
	  windowmaker.enable = true;
	  wmii.enable = true;
	  xmonad.enable = true;
	  xmonad.enableContribAndExtras = true;
          default = "twm";
       };
   };
   compton = {
      #  enable          = true;
      fade            = true;
      inactiveOpacity = "0.9";
      shadow          = true;
      fadeDelta       = 4;
   };
  };

  users.mutableUsers = true;
  users.extraUsers.domini = { # Define a user account. Don't forget to set a password with ‘passwd’.
     name = "domini";
     isNormalUser = true;
     uid = 1000;
     description = "Domini Montessori";
     group = "users";
     extraGroups = [ "wheel" "root" "kmem" "tty" "messagebus" "disk" "audio" "floppy" "uucp" "lp" "cdrom" "tape" "video" "dialout" "utmp" "adm" "networkmanager" "scanner" "systemd-journal" "libvirtd" "lightdm" "keys" "users" "systemd-journal-gateway" "docker" "systemd-network" "systemd-resolve" "systemd-timesync" "input" "nm-openvpn" "wireshark" "sway" "camera" "adbusers" "nixbld" "vboxuser" ];
     home = "/home/domini";
     createHome = true;
     useDefaultShell = true;
     openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3NzaC1kc3MAAACBAOhcMJyuEf4AgS/LFwC23A/bcsGOkM33Mdoba5BXLHFE7UK62FteESwYNvY7oeSkJbsLzdpx6ntZmq5dNiWHCboqwtnzpVqL/PC0MGwLjuOuV43/k8+xYy2p2bJHb/mzuV9ew1sheK7F5f8LASkBGNiu5CR5puSxsnAaj8Bzi6GPAAAAFQDpO3+76Pj2I+STO7+afJMpht371QAAAIAHumBbnFiweZFHb7sqVphL7e1e35A09bzCzHh7SHAWQ817lkfM+LdeX2rTAxaufL2g7RBn10R4OyFbsTFiNpTo4KOsoPjeerOpJe4rR03gkXNWO1aOwx9kWJ5IjC7DgH6N+j7Oz7jXU9cGMa95QpN3UMCuDTnyQhozahP3gCEA+AAAAIBw2rcyQA6koR3XGkSq1XY/1rPZKPGFoCjSFf1R+OyNp8zkQ09rM9payU9nyirR8HOy5j1+y3F2e/5Sf9dpBfk0+bsqgwUCu3YoKl7uq8TROIU+eIwZKaytq/cVBaup5poee0GR4kn/dX4tV6qrh3cDIFl/SgUgkxJdunRb9VZtSQ== domini@absolon.hitech.local.prv" ];
  };

  system.copySystemConfiguration = true;
  system.autoUpgrade.enable = true; 
  system.stateVersion = "18.03"; #"17.09"; # "17.03"; # The NixOS release to be compatible with for stateful data such as databases.
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable; #https://nixos.org/channels/nixos-17.09; #https://nixos.org/channels/nixos-17.03;

  nixpkgs.config = {
      allowUnfree = true;
      allowBroken = true;
      pulseaudio = true;
      permittedInsecurePackages = [ "samba-3.6.25" ];
      chromium = { enablePepperFlash = true;  };
      overlays = [
          (import /etc/nixos/overlays/nixpkgs-mozilla/rust-overlay.nix)
          ];
  };

  nix = {
      buildCores = 0;
      daemonIONiceLevel = 4;
      daemonNiceLevel = 10;
      maxJobs = 8; #4
      gc.automatic = false;
      gc.dates = "daily";
      gc.options = "--delete-older-than 1h";
      #nixPath = [ "/etc/nixos" "nixos-config=/etc/nixos/configuration.nix" ];
      useSandbox = true; #nix.useChroot
      binaryCaches = [ http://cache.nixos.org http://hydra.nixos.org "https://nixcache.reflex-frp.org" ];
      binaryCachePublicKeys =  [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
      trustedUsers =  [ "root" "domini" "@wheel" ];
      extraOptions = ''
              auto-optimise-store = true
              gc-keep-outputs = false
              gc-keep-derivations = false
              build-use-sandbox = true
              build-chroot-dirs = $(nix-store -qR $(nix-build '<nixpkgs>' -A bash) | xargs echo /bin/sh=$(nix-build '<nixpkgs>' -A bash)/bin/bash)
              build-max-jobs = 5
              build-cores = 2
              trusted-users = root domini
              allowed-users = *
      '';
  };



}



 