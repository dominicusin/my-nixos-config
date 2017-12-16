{ config, lib, pkgs, ... }:

{
  require = [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      #(builtins.fetchgit https://github.com/edolstra/dwarffs + "/module.nix")
  ];
  imports =
    [
      ./hardware-configuration.nix
      ./mount.nix
      ./domini.nix
      ./xserver.nix
      ./boot.nix
      ./virtualisation.nix
      ./services.nix
    ];
  networking = {
      hostName = "absolon";
      hostId = "a8c0b902";
      networkmanager.enable = true;
      networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
      nameservers = [ "8.8.8.8" "8.8.4.4" ];
      timeServers = [ "time.as43289.net" "ntp3.usv.ro" "ntp1.usv.ro" "pool1.ntp.od.ua" "3.md.pool.ntp.org""2.europe.pool.ntp.org" "3.europe.pool.ntp.org" "2.nixos.pool.ntp.org" ];
      wireless.enable = false;
      enableIPv6 = true;
      firewall.enable = false;
  };
  i18n = {
     consoleFont = "cyr-sun16";
     consoleKeyMap = "ru";
     defaultLocale = "ru_RU.UTF-8";
  };
  time.timeZone = "Europe/Tiraspol";

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = import ./packages.nix pkgs;
  powerManagement = { enable = true; cpuFreqGovernor = "performance"; };


   nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    sc2-headless.accept_license = true;
    firefox = {
     enableGoogleTalkPlugin = true;
     enableAdobeFlash = true;
     enableGnomeExtensions = true;
     enableGeckoMediaPlayer = true;
    };
    chromium = {
     enablePepperFlash = true;
     enablePepperPDF = true;
     enableGnomeExtensions = true;
    };
    #stdenv.userHook = ''
    #   NIX_CFLAGS_COMPILE+=" -march=native -O2 -pipe"
    #'';

   };

}
