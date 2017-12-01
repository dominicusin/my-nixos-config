
pkgs: with pkgs; [
    (python.buildEnv.override { extraLibs = [ pythonPackages.ipython ]; })
    (haskellPackages.ghcWithPackages (p: with p; [ turtle ]))

    #rustChannels.beta.rust (llvm.override { enableSharedLibraries = true; })

    #wmctrl xautolock xclip xe xidel xlsfonts xorg xsel xss-lock 
    # plantuml platformio playonlinux popfile proxychains psmisc pwgen
    # pypi2nix python27Packages.libvirt python27Packages.pip python2Full python35 python35Packages.docker_compose python35Packages.libvirt python35Packages.paho-mqtt
    # python35Packages.pip python35Packages.virtualenv pythonPackages.dopy pythonPackages.ipython pythonPackages.markupsafe pythonPackages.pyaml  pythonPackages.yamllint pythonPackages.yapf
    # rfkill rsync ruby rustracer s3cmd screen scribus shellcheck simple-scan simplescreenrecorder skype slack spotify sqldeveloper sshpass steam stow subversionClient sysdig system-config-printer tcpdump terminator
    # testdisk transmission_gtk tree unzipNLS vagrant virtmanager virt-viewer visualvm vlc weechat wineStaging winetricks wireshark-gtk xdg-user-dirs zeal zsh

   abduco abiword ack acpi adobe-reader amsn android-studio anki ansible ansible2 ant apparmor-pam apparmor-parser apparmor-profiles apparmor-utils arandr  arduino aria2 asciinema aspell aspellDicts.en 
   aspellDicts.fr atom atool autoconf aws-auth awscli axel babeltrace bar-xft bazaar bc bedup beets bind binutils bitcoin bitcoin-xt bitlbee bitlbee-facebook bitlbee-steam blink blueman bmon boot bridge-utils bundix bwm_ng 
   cabal2nix calc calibre cargo cdrkit centerim chromium cifs_utils citrix_receiver clang clerk clipit cloc cloud-init cmake cmus cnijfilter2 cntlm compton containerd coq coreutils corkscrew coyim ctags cups-bjnp curl cvs 
   cvs_fast_export dapp darcs davmail ddate debootstrap deluge desktop_file_utils devilspie2 dhcp dhcpcd di dia dino discord dmenu dmenu2 dmidecode dnsmasq docbook5 docbook_xml_xslt docker docker-machine docker-machine-kvm 
   dos2unix dropbox dunst duperemove dvtm ebtables eclipses.eclipse-platform ekiga elementary-icon-theme elinks elixir emacs evince exiv2 expect fasd fdupes ffmpeg file filezilla firefox firefox-beta-bin-unwrapped 
   firefox-devedition-bin-unwrapped flac fop fortune franz freemind freerdp freetalk fuse fzf gajim gcc gcc6 gdb ghostscriptX gimp git gitAndTools.gitFull gitFull glib global glxinfo gnome3.cheese gnome3.gconf 
   gnome3.networkmanager_openconnect gnome3.pomodoro gnucash gnumake gnupg go go2nix google-chrome google-cloud-sdk gpm gradle graphviz gtk2 gtk-recordmydesktop gtmess gtypist guile haskellPackages.ghc-mod 
   haskellPackages.hledger haskellPackages.hledger-web hdparm hevm hicolor_icon_theme hipchat hplip htop httpie i3 i3lock i3status icedtea_web idea.pycharm-community iftop imagemagick inetutils inkscape iomelt iptables irssi 
   isync iw jackline jdk jitsi jmtpfs jnettop jq kadu keepassx2 konsole kubernetes languagetool ledger leiningen libguestfs libinput libmysql libnotify libpcap libproxy libreoffice libsysfs libva libvirt libxml2 libxslt libyaml 
   links linphone lr lsh lsof ltrace lttng-tools lttng-ust lxc lynx man-pages maven mc mcabber meld mercurial mercurialFull messenger-for-desktop midori mikutter minikube mkpasswd mm mongodb-tools mosh mosquitto most mpv msmtp 
   mtr nasm ncdu ncmpcpp ncurses neomutt neovim nethogs networkmanagerapplet networkmanager_openvpn nfs-utils nixops nix-prefetch-git nix-prefetch-scripts nix-repl nixUnstable nmap nodejs nodePackages.coffee-script 
   nodePackages.gulp notmuch nq nss nssTools ntfs3g ntopng okular openconnect openjdk openocd openssl openvswitch opera oraclejdk8 oysttyer p7zip packer pagemon pandoc paprefs pass patchelf pavucontrol pciutils pdftk peco 
   pgadmin php php70Packages.composer pianobar pidgin pidgin-with-plugins pinentry pipelight pkgconfig pkgs.chromium pkgs.nitrogen pkgs.terminator pkgs.xfce.thunar playerctl pond powertop profanity psi psi-plus psmisc pwgen 
   pybitmessage python27Packages.docker_compose python2Full python36Full qpdfview qt5.qtbase qtox quasselClient quaternion quilt racket rambox ranger ratox reptyr ricochet ripgrep rofi rpm rpm-ostree rtags rxvt_unicode 
   rxvt_unicode_with-plugins s3cmd samba screen scrot scudcloud seth shared_mime_info signal-desktop silver-searcher skype skypeforlinux slack socat spotify sqlite sshfsFuse sshpass stack stalonetray stellar-core stow 
   stunnel sublime3 subversion sway sxhkd sxiv sysstat taffybar tango-icon-theme taskwarrior tensor termite texstudio tmux torbrowser toxic transmission_gtk tree turses tuxguitar tweak unclutter unrar unzip urlview usbutils 
   utillinux utox vacuum valgrind vanilla-dmz vdpauinfo viber vifm vim vimHugeX vis vlc vmtouch vnstat w3m w3m-full watchman wayland weechat weechat-matrix-bridge weechat-xmpp wget which wine winetricks xautolock xclip xdg_utils 
   xdotool xfce.exo xfce.gtk_xfce_engine xfce.gvfs xfce.terminal xfce.thunar xfce.thunar_volman xfce.xfce4icontheme xfce.xfce4settings xfce.xfconf xfontsel xlibs.xev xlockmore xmpp-client xorg.xdpyinfo xorg.xkill xorg.xmodmap 
   xsane xsel xss-lock yakuake youtube-dl z3 zathura zfs zfstools zip zoom-us zsh zsh-autosuggestions zsh-completions zsh-git-prompt zsh-navigation-tools zsh-prezto zsh-syntax-highlighting 
   debootstrap gpgme
 bind 
    cryptsetup
    dmidecode
    dstat
    file
    git
    gptfdisk
    gnupg20
    htop
    iftop
    iotop
    linuxPackages.perf
    lshw
    lsof
    mtr
    nftables
    pciutils
    psmisc
    sysdig
    tcpdump
    tmux
    tree
    unzip
    wget
    which
   wireshark

]

