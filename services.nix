{ config, lib, pkgs, ... }:

{

  services = {  # List services that you want to enable:
      gpm.enable = true;
      openssh.enable = true;
      nixosManual.showManual = true;
      kbfs.enable = true;
      acpid.enable = true;
      dnsmasq.enable = false;
      gnome3.tracker.enable = false;
      dbus = {
          enable =true;
          packages = [ pkgs.gnome2.GConf pkgs.gnome2.GConf.out ];
      };
      redis =   {
          enable = false;
          unixSocket = "/tmp/redis.sock";
      };
      printing = {
        enable = true; # Enable CUPS to print documents.
        drivers = [ pkgs.hplipWithPlugin ];
      };
      compton = {
      enable          = false;
      fade            = true;
      inactiveOpacity = "0.9";
      shadow          = true;
      fadeDelta       = 4;
     };
  };
}

