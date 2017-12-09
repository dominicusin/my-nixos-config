
pkgs: with pkgs; [

    (import ./emacs.nix { inherit pkgs; })
    eclipses.eclipse-platform
    gnome3.cheese gnome3.gconf gnome3.networkmanager_openconnect gnome3.pomodoro
    idea.pycharm-community
    linuxPackages.perf
    nodePackages.coffee-script nodePackages.gulp
    php70Packages.composer
    python27Packages.docker_compose python27Packages.libvirt python27Packages.pip 
    python35Packages.docker_compose python35Packages.libvirt python35Packages.paho-mqtt python35Packages.pip python35Packages.virtualenv 
    qt5.qtbase
    xfce.exo xfce.gtk_xfce_engine xfce.gvfs xfce.terminal xfce.thunar xfce.thunar_volman xfce.xfce4icontheme xfce.xfce4settings xfce.xfconf 
    xlibs.xev
    xorg.xdpyinfo xorg.xkill xorg.xmodmap xorg.xinit
    #sqldeveloper
    zile mg


    abduco abiword ack acpi adobe-reader amsn android-studio anki ansible ansible2 ant apparmor-pam apparmor-parser apparmor-profiles apparmor-utils arandr arduino aria2 asciinema aspell atom atool autoconf aws-auth awscli 
    axel babeltrace bar-xft bazaar bc bedup beets bind binutils bitcoin bitcoin-xt bitlbee bitlbee-facebook bitlbee-steam blink blueman bmon boot bridge-utils bundix bwm_ng cabal2nix calc calibre cargo cdrkit centerim 
    chromium cifs_utils citrix_receiver clang clerk clipit cloc cloud-init cmake cmus cnijfilter2 cntlm compton containerd coq coreutils corkscrew coyim cryptsetup ctags cups-bjnp curl cvs cvs_fast_export dapp darcs davmail 
    ddate debootstrap deluge desktop_file_utils devilspie2 dhcp dhcpcd di dia dino discord dmenu dmenu2 dmidecode dnsmasq docbook5 docbook_xml_xslt docker docker-machine docker-machine-kvm dos2unix dropbox dstat dunst 
    duperemove dvtm ebtables ekiga elementary-icon-theme elinks elixir emacs evince exiv2 expect fasd fdupes ffmpeg file filezilla firefox-beta-bin-unwrapped firefox-devedition-bin-unwrapped flac fop fortune franz freemind 
    freerdp freetalk fuse fzf gajim gcc gcc6 gdb ghostscriptX gimp gitFull glib global glxinfo gnucash gnumake go go2nix google-chrome google-cloud-sdk gpgme gpm gptfdisk gradle graphviz gtk2 gtk-recordmydesktop gtmess gtypist 
    guile hdparm hevm hicolor_icon_theme hipchat htop httpie i3 i3lock i3status icedtea_web iftop imagemagick inkscape iomelt iotop iptables irssi isync iw jackline jitsi jmtpfs jnettop jq kadu keepassx2 konsole kubernetes 
    languagetool ledger leiningen libguestfs libinput libmysql libnotify libpcap libproxy libreoffice libsysfs libva libvirt libxml2 libxslt libyaml links linphone lr lsh lshw lsof ltrace lttng-tools lttng-ust lxc lynx maven mc 
    mcabber meld mercurialFull midori mikutter minikube mkpasswd mm mongodb-tools mosh mosquitto most mpv msmtp mtr nasm ncdu ncmpcpp ncurses neomutt neovim nethogs networkmanagerapplet networkmanager_openvpn nfs-utils nftables 
    nitrogen nixops nix-prefetch-git nix-prefetch-scripts nix-repl nixUnstable nmap nodejs notmuch nq nss nssTools ntfs3g ntopng okular openconnect openocd openssl openvswitch opera oysttyer p7zip packer pagemon pandoc paprefs 
    pass patchelf pavucontrol pciutils pdftk peco pgadmin php pianobar pidgin pidgin-with-plugins pinentry pipelight pkgconfig plantuml platformio playerctl playonlinux pond popfile powertop profanity proxychains psi 
    psi-plus psmisc pwgen pybitmessage pypi2nix python2Full python35 python36Full qpdfview qtox quasselClient quaternion quilt racket rambox ranger ratox reptyr rfkill ricochet ripgrep rofi rpm rpm-ostree rsync rtags ruby 
    rustracer s3cmd samba screen scribus scrot scudcloud seth shared_mime_info shellcheck silver-searcher simple-scan simplescreenrecorder skype skypeforlinux slack socat spotify  sqlite sshfsFuse sshpass stack 
    stalonetray steam stellar-core stow stunnel sublime3 subversion sxhkd sxiv sysdig sysstat system-config-printer taffybar tango-icon-theme taskwarrior tcpdump tensor terminator termite testdisk texstudio tmux torbrowser 
    toxic transmission_gtk tree turses tuxguitar tweak unclutter unrar unzip urlview usbutils utillinux utox vacuum vagrant valgrind vanilla-dmz vdpauinfo viber vifm vimHugeX virtmanager virt-viewer vis visualvm vlc vmtouch 
    vnstat w3m-full watchman wayland weechat weechat-matrix-bridge weechat-xmpp wget which wine wineStaging winetricks wmctrl xautolock xclip xdg-user-dirs xdg_utils xdotool xfontsel xidel xlockmore xlsfonts 
    xmpp-client xsane xsel xss-lock yakuake youtube-dl z3 zathura zeal zfs zfstools zip zoom-us zsh zsh-autosuggestions zsh-completions zsh-git-prompt zsh-navigation-tools zsh-prezto zsh-syntax-highlighting 


]
 ++ (with aspellDicts; [ en ru])
 ++ (with haskellPackages; [ ghc-mod hledger hledger-web ])
 ++ (with pythonPackages; [ dopy ipython markupsafe pyaml yamllint yapf])
 
