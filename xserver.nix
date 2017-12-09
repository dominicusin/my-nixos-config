{ config,lib, pkgs, ... }:

{
  services.xserver = {
       enable = true;
       layout = "us,ru(winkeys)";
       enableCtrlAltBackspace = true;
       libinput.enable = true;
       xkbModel="geniuscomfy2";
       xkbOptions = "grp:alt_shift_toggle,grp:win_switch,terminate:ctrl_alt_bksp,grp_led:scroll,altwin:menu";
       videoDrivers = [ "intel" ];
       desktopManager = {
          enlightenment.enable = true; #e19.enable = true;
          gnome3.enable = true;
          gnome3.extraGSettingsOverridePackages = [ pkgs.gnome3.nautilus ];
          #gnome3.extraGSettingsOverrides
          #gnome3.sessionPath = [ pkgs.gnome3.gpaste ];
          #kde5 = true;
          #kodi.enable = true; #xbmc
          #lumina.enable = true;
          #lxqt.enable = true;
          mate.enable = true;
          plasma5.enable = true;
          plasma5.enableQt4Support = true;
          xfce.enable = true;
          xfce.enableXfwm = true;
          xfce.noDesktop = false;
          xfce.screenLock = "xscreensaver";
          xfce.thunarPlugins = [ pkgs.xfce.thunar-archive-plugin pkgs.xfce.thunar_volman pkgs.xfce.thunar-dropbox-plugin ];
          xterm.enable = false;
          default = "xfce"; #"plasma5";"gnome3";"mate";"Enlightenment";
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
          metacity.enable = true;
          mwm.enable = true;
          notion.enable = true;
          openbox.enable = true;
          pekwm.enable = true;
          qtile.enable = true;
          ratpoison.enable = true;
          sawfish.enable = true;
          spectrwm.enable = true;
          twm.enable = true;
          windowlab.enable = true;
          windowmaker.enable = true;
          wmii.enable = true;
          xmonad.enable = true;
          xmonad.enableContribAndExtras = true;
       };
   };

}
