#!/bin/bash

if [ $(whoami) != "root" ]; then
	echo "Must be run as root."
	exit 1
fi

deltacp()
{
	SRC="$1"
	DST="$2"
	START="#START MORTCUSTOM"
	END="#END MORTCUSTOM"

	if grep "$START" "$DST" > /dev/null; then
		sed -i "/$START/,/$END/d" "$DST"
	fi

	echo "$START" >> "$DST"
	cat "$SRC" >> "$DST"
	echo "$END" >> "$DST"
}

cpr()
{
	rm -r "$2";
	cp "$1" "$2";
}

cp setup/profile.sh /etc/profile.d/mort-custom.sh
deltacp setup/fstab /etc/fstab

mkdir -p tmp
mkdir -p mnt
mkdir -p src
mkdir -p cloud
[ ! -d uni ] && ln -s cloud/uni uni
[ ! -d dev ] && ln -s cloud/dev dev

cpr setup/config/dunst .config/dunst

exit 0
