{ config, lib, pkgs, ... }:


{

  security.sudo.configFile="
       root    ALL=(ALL) ALL
       domini  ALL=(ALL) NOPASSWD: ALL
  ";

  security.pam.loginLimits = [
      { domain = "domini"; type = "-"; item = "memlock"; value = "unlimited"; }
      { domain = "domini"; type = "soft"; item = "nproc"; value = "65000"; }
      { domain = "domini"; type = "hard"; item = "nproc"; value = "1000000"; }
      { domain = "domini"; type = "-"; item = "nofile"; value = "1048576"; }
      { domain = "domini"; item = "nofile"; type = "-"; value = "999999"; }
      { domain = "domini"; item = "memlock"; type = "-"; value = "unlimited"; }
      { domain = "domini"; item = "rtprio"; type = "-"; value = "99"; }
      { domain = "domini"; item = "nofile"; type = "soft"; value = "99999"; }
      { domain = "domini"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  environment.etc = {
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


  services = { 
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
    syncthing = {
        enable = true;
        useInotify = true;
        user = "domini";
        dataDir = "/home/domini/.syncthing";
        openDefaultPorts = true;
    };
    xserver.displayManager = {
          auto.enable = false; auto.user = "domini";
          #gdm.enable = false; gdm.autoLogin.enable = true; gdm.autoLogin.user = "domini"; 
          #sddm.enable = false; sddm.autoLogin.enable = true; sddm.autoLogin.user = "domini";
          #slim.enable = false; slim.autoLogin.enable = true; slim.autoLogin.user = "domini";
          lightdm.enable = true; lightdm.autoLogin.enable = true; lightdm.autoLogin.user = "domini";
       };

  users.mutableUsers = true;
  users.extraUsers.domini = { # Define a user account. Don't forget to set a password with ‘passwd’.
     name = "domini";
     isNormalUser = true;
     uid = 1000;
     description = "Domini Montessori";
     group = "users";
     extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"  "vboxuser" "docker" ];
     home = "/home/domini";
     createHome = true;
     useDefaultShell = true;
     openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3NzaC1kc3MAAACBAOhcMJyuEf4AgS/LFwC23A/bcsGOkM33Mdoba5BXLHFE7UK62FteESwYNvY7oeSkJbsLzdpx6ntZmq5dNiWHCboqwtnzpVqL/PC0MGwLjuOuV43/k8+xYy2p2bJHb/mzuV9ew1sheK7F5f8LASkBGNiu5CR5puSxsnAaj8Bzi6GPAAAAFQDpO3+76Pj2I+STO7+afJMpht371QAAAIAHumBbnFiweZFHb7sqVphL7e1e35A09bzCzHh7SHAWQ817lkfM+LdeX2rTAxaufL2g7RBn10R4OyFbsTFiNpTo4KOsoPjeerOpJe4rR03gkXNWO1aOwx9kWJ5IjC7DgH6N+j7Oz7jXU9cGMa95QpN3UMCuDTnyQhozahP3gCEA+AAAAIBw2rcyQA6koR3XGkSq1XY/1rPZKPGFoCjSFf1R+OyNp8zkQ09rM9payU9nyirR8HOy5j1+y3F2e/5Sf9dpBfk0+bsqgwUCu3YoKl7uq8TROIU+eIwZKaytq/cVBaup5poee0GR4kn/dX4tV6qrh3cDIFl/SgUgkxJdunRb9VZtSQ== domini@absolon.hitech.local.prv" ];
  };

  nix = {
      trustedUsers =  [ "root" "domini" "@wheel" ];
      extraOptions = ''
              trusted-users = root domini
              allowed-users = root domini
      '';
  };



}

