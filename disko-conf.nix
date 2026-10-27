{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda"; #укажите свой диск
        content = {
          type = "gpt";
          partitions = {
            # Загрузочный раздел
            ESP = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            
            # Шифрованный раздел(всё остальное место)
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };
    
    # LVM-тома внутри luks-раздела
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          # Раздел подкачки
          swap = {
            size = "8G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          
          # Корневой раздел
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
