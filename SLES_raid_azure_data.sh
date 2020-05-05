#!/bin/bash
zypper install -y mdadm
n=$(find /dev/disk/azure/scsi1/ -name "lun*"|wc -l)
n="${n//\ /}"
mdadm --create /dev/md0 --level=stripe --raid-devices=$n /dev/disk/azure/scsi1/lun*
mkfs.xfs /dev/md0
mkdir /mnt/raid0
echo "$(sudo blkid /dev/md0 | cut -d ' ' -f 2) /mnt/raid0 xfs defaults 0 0" | tee -a /etc/fstab
mount /mnt/raid0
