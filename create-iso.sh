#!/bin/bash
if [ "$EUID" -ne 0 ]; then echo "Please run as root"; exit; fi
if [ $# -eq 0 ]; then echo "Usage: $0 [iso]"; exit; fi

hostname=$1
work_dir=/home/morten/vm-setup
iso_dir=/var/lib/libvirt/images
iso=$iso_dir/$hostname.iso
#sudo cloud-localds -v -N $workdir/network-config.yml /var/lib/libvirt/images/debbie.iso $workdir/debian-k8s-user.yml $workdir/debian-k8s-meta.yml
#sudo cloud-localds -v $iso $work_dir/debian-k8s-user.yml $work_dir/debian-k8s-meta.yml
sudo cloud-localds -v -H $hostname $iso $work_dir/debian12-k8s-user.yml

