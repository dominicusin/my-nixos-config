{

#  fileSystems."/mnt/dos" =
#    { device = "/dev/disk/by-uuid/C800-BA3F";
#      fsType = "vfat";
#      options = [ "user" "fmask=02" "dmask=02" "codepage=866" "iocharset=utf8" "x-systemd.automount"  ];
#    };


#   fileSystems."/mnt/win" =
#     { device = "/dev/disk/by-label/Win";
#       fsType = "ntfs-3g";
#       options = [ "allow_other" "fmask=02" "dmask=02" "x-systemd.automount" ];
#     };


#   fileSystems."/mnt/helly/C" =
#     { device = "//helly/C";
#       fsType = "cifs";
#       options = [ "username=domini" "password=Hfvinfqy1" "file_mode=02" "dir_mode=02" "x-systemd.automount" ];
#     };


  fileSystems."/mnt/helly/D" =
     { device = "//192.168.2.160/D";
       fsType = "cifs";
       options = [ "username=domini" "password=Hfvinfqy1" "file_mode=02" "dir_mode=02" "x-systemd.automount" ];
     };

   fileSystems."/" = { options = ["noatime" "nodiratime" "compress=zlib"];  };
   fileSystems."/mnt/btrfs" = { options = [ "subvol=/" "noatime" "nodiratime" "compress=zlib" ]; };
   

}

