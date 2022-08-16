#!/bin/bash
if [ "$EUID" -ne 0 ]; then echo "Please run as root"; exit; fi
if [ $# -eq 0 ]; then echo "Usage: $0 [VM disk]"; exit; fi

disk_dir=/var/lib/libvirt/images
#remote_source=http://cloud.debian.org/images/cloud/bookworm/daily/latest/debian-12-genericcloud-amd64-daily.qcow2
remote_source=https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-genericcloud-amd64.qcow2
local_source=$disk_dir/${remote_source##*/}
disk_name=$disk_dir/$1
disk_size=20G

if [ ! -f $local_source ] 
  then echo $local_source && wget -O $local_source $remote_source
fi

if [ ! -f $disk_name ]
  then 
    echo "Copy locale source file to target file" 
    cp -vf $local_source $disk_name
    qemu-img resize $disk_name $disk_size
else
  if [ "$2" != "yes" ]
  then
    read -p "Overwrite existing $disk_name? " -n 1 -r
    echo   # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
      [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
    fi
  fi
  cp -vf $local_source $disk_name
  qemu-img resize $disk_name $disk_size
  #rm -fv $disk_name
  #qemu-img create -f qcow2 -F qcow2 -b $local_source $disk_name
fi





