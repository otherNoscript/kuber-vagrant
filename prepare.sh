#!/bin/bash

ISO_TMP="/opt/ubuntu_1710"
ISO_NAME="unattend_ubnt_1710"
ISO_HTTP="http://ftp.yandex.ru/ubuntu-releases/17.10/ubuntu-17.10.1-server-amd64.iso"
ISO_HTTP_NAME=$(basename $ISO_HTTP)

KVM_HOME="/var/lib/libvirt/"
KVM_TEMPLATE_IMG="template_ubnt1710.img"
KVM_TEMPLATE_NAME="ubuntu_1710.template"
ISO_SAVE="$KVM_HOME/boot/$ISO_NAME.iso"
MNT_TMP=$(mktemp -d)

if [[ ! -f $ISO_HTTP_NAME ]]; then
    curl -O $ISO_HTTP
fi

mount -o loop $ISO_HTTP_NAME $MNT_TMP
mkdir $ISO_TMP
cp -rT $MNT_TMP $ISO_TMP
umount $MNT_TMP
rm -rf $MNT_TMP

apt-get update
apt-get -y install qemu-kvm libvirt-bin bridge-utils virt-manager ansible mkisofs libguestfs-tools

cp -r unattend_ubnt/* $ISO_TMP/

mkisofs -U -A "$ISO_NAME" -V "1710" -volset "$ISO_NAME" -J -joliet-long -r -v -T -o $ISO_SAVE -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot $ISO_TMP

rm -rf $ISO_TMP

virt-install --virt-type=qemu --name $KVM_TEMPLATE_NAME --ram 2048 --vcpus=2 --graphics vnc,listen=0.0.0.0 --cdrom=$ISO_SAVE --network network=default,model=virtio --disk path=$KVM_HOME/images/$KVM_TEMPLATE_IMG,size=16,bus=virtio

virsh shutdown $KVM_TEMPLATE_NAME
virsh dumpxml $KVM_TEMPLATE_NAME > $KVM_HOME/images/$KVM_TEMPLATE_NAME.xml
virsh autostart --disable $KVM_TEMPLATE_NAME
virt-sysprep -a $KVM_HOME/images/$KVM_TEMPLATE_NAME.img

