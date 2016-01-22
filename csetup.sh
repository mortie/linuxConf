#!/bin/sh

try()
{
	"$@"
	if [ $? != 0 ]; then
		echo "Command failed: $@"
		exit 1
	fi
}

davstab="http://dav.mort.coffee /mnt/dav davfs user,noauto,uid=martin,file_mode=600,dir_mode=700 0 1"

cleanup()
{
	cat /etc/fstab | grep -v "davstab" > ~/__tmp
	try sudo mv ~/__tmp /etc/fstab
}

cleanup

try sudo mkdir -p /mnt
try sudo mkdir -p /mnt/netdisk
try sudo mkdir -p /mnt/dav
umount /mnt/netdisk
umount /mnt/dav

mkdir -p ~/.davfs2
PASS=$(mpass get seafile out)
try echo http://dav.mort.coffee martid0311@gmail.com $PASS > ~/.davfs2/secrets
try chmod 0600 ~/.davfs2/secrets
su -c "echo $davstab >> /etc/fstab"
try mount /mnt/dav
try rm -r ~/dav
try ln -s /mnt/dav/dav ~/dav
