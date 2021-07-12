# Домашнее задание к занятию "3.5. Файловые системы"
2. не могут. исходный файл и все жесткие ссылки указывают на один и тот же участок жесткого диска
4. ```bash
   root@vagrant:/home/vagrant# fdisk -l /dev/sdb
    Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0xf73d8a1a

    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdb1          2048 4196351 4194304    2G 83 Linux
    /dev/sdb2       4196352 5242879 1046528  511M 83 Linux
   ```
   
5. ```shell
    root@vagrant:/home/vagrant# sfdisk --dump /dev/sdb > /tmp/tables
    root@vagrant:/home/vagrant# sfdisk /dev/sdc < /tmp/tables
    Checking that no-one is using this disk right now ... OK
    
    Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Created a new DOS disklabel with disk identifier 0xf73d8a1a.
    /dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
    /dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
    /dev/sdc3: Done.
    
    New situation:
    Disklabel type: dos
    Disk identifier: 0xf73d8a1a
    
    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdc1          2048 4196351 4194304    2G 83 Linux
    /dev/sdc2       4196352 5242879 1046528  511M 83 Linux
    
    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.
    ```
   
6. ```shell
    root@vagrant:/home/vagrant# mdadm --create /dev/md1 -l 1 -n2 /dev/sdb1 /dev/sdc1
    mdadm: Note: this array has metadata at the start and
        may not be suitable as a boot device.  If you plan to
        store '/boot' on this device please ensure that
        your boot-loader understands md/v1.x metadata, or use
        --metadata=0.90
    Continue creating array?
    Continue creating array? (y/n) y
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md1 started.
    ```
   
7. ```shell
    root@vagrant:/home/vagrant# mdadm --create /dev/md2 -l 0 -n2 /dev/sdb2 /dev/sdc2
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md2 started.
    ```
   
8. ````bash
    root@vagrant:/home/vagrant# pvcreate /dev/md1
      Physical volume "/dev/md1" successfully created.
    root@vagrant:/home/vagrant# pvcreate /dev/md2
      Physical volume "/dev/md2" successfully created.
    ````
   
9. ```bash
    root@vagrant:/home/vagrant# vgcreate group1 /dev/md1 /dev/md2
    Volume group "group1" successfully created
    ```
   
10. ```bash
    root@vagrant:/home/vagrant# lvcreate -L100M -n first group1
    Logical volume "first" created.
    ```
    
11. ```bash
    root@vagrant:/home/vagrant# mkfs.ext4 /dev/group1/first
    mke2fs 1.45.5 (07-Jan-2020)
    Creating filesystem with 25600 4k blocks and 25600 inodes

    Allocating group tables: done
    Writing inode tables: done
    Creating journal (1024 blocks): done
    Writing superblocks and filesystem accounting information: done
    ```
    
12. ```bash
    root@vagrant:/home/vagrant# mkdir /tmp/new
    root@vagrant:/home/vagrant# mount /dev/group1/first /tmp/new/
    ```
    
13. ````bash
    root@vagrant:/home/vagrant# mkdir /tmp/new
    root@vagrant:/home/vagrant# mount /dev/group1/first /tmp/new/
    root@vagrant:/home/vagrant# cd /tmp/new/ && wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
    --2021-07-12 11:25:56--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
    Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
    Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 21043232 (20M) [application/octet-stream]
    Saving to: ‘/tmp/new/test.gz’
    
    /tmp/new/test.gz          100%[===================================>]  20.07M  4.38MB/s    in 5.6s
    
    2021-07-12 11:26:07 (3.57 MB/s) - ‘/tmp/new/test.gz’ saved [21043232/21043232]

    ````
14. ```bash
    root@vagrant:/tmp/new# lsblk
    NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    sda                    8:0    0   64G  0 disk
    ├─sda1                 8:1    0  512M  0 part  /boot/efi
    ├─sda2                 8:2    0    1K  0 part
    └─sda5                 8:5    0 63.5G  0 part
      ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
      └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
    sdb                    8:16   0  2.5G  0 disk
    ├─sdb1                 8:17   0    2G  0 part
    │ └─md1                9:1    0    2G  0 raid1
    │   └─group1-first   253:3    0  100M  0 lvm   /tmp/new
    └─sdb2                 8:18   0  511M  0 part
      └─md2                9:2    0 1018M  0 raid0
    sdc                    8:32   0  2.5G  0 disk
    ├─sdc1                 8:33   0    2G  0 part
    │ └─md1                9:1    0    2G  0 raid1
    │   └─group1-first   253:3    0  100M  0 lvm   /tmp/new
    └─sdc2                 8:34   0  511M  0 part
      └─md2                9:2    0 1018M  0 raid0
    ```
    
15. ```bash
    root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz
    root@vagrant:/tmp/new# echo $?
    0 
    ```
    
16. ```bash
    root@vagrant:/tmp/new# pvmove /dev/md1 /dev/md2
    /dev/md1: Moved: 20.00%
    /dev/md1: Moved: 100.00%
    ```
    
17. ````bash
    root@vagrant:/tmp/new# mdadm --fail /dev/md1 /dev/sdb1
    mdadm: set /dev/sdb1 faulty in /dev/md1
    root@vagrant:/tmp/new# dmesg | grep "md/raid1"
    [  993.499677] md/raid1:md1: not clean -- starting background reconstruction
    [  993.499678] md/raid1:md1: active with 2 out of 2 mirrors
    [ 3249.351705] md/raid1:md1: Disk failure on sdb1, disabling device.
                   md/raid1:md1: Operation continuing on 1 devices.
    ````
    
18. ```bash
    root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz
    root@vagrant:/tmp/new# echo $?
    0 
    ```