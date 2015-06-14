#!/bin/bash

issues=0

check_command()
{
	exists=0

	for arg in "$@"; do
		which "$arg" &> /dev/null
		if [ "$?" -eq 0 ]; then
			exists=1
		fi
	done

	if [ "$exists" -eq 0 ]; then
		issues=1
		echo "Missing command: $@"
	fi
}

check_file()
{
	if [ ! -f "$1" ]; then
		issues=1
		echo "Missing file: $1"
	fi
}

check_command "zsh"
check_command "tmux"
check_command "vim"
check_command "python"
check_command "xdotool"
check_command "compton"
check_command "amixer"
check_command "xbacklight"
check_command "feh"
check_command "xsel" "pbcopy"
check_command "recordmydesktop"
check_command "mplayer"
check_command "scrot" "screencapture"
check_command "notify-send" "terminal-notifier"
check_command "dunst" "terminal-notifier"
check_command "curl"
check_command "sudo"
check_command "mutt"

if [ $issues -ne 0 ]; then
	echo "Some things are missing. Continue? (y/n)"
	read response
	if [ "$response" != "y" ]; then
		echo "Aborting."
		exit 1
	fi
fi

echo "Copying dotfiles..."
cd dotfiles
for f in *; do
	rm -rf "$HOME/.$f"
	cp -r "$f" "$HOME/.$f"
done
cd ..
echo "Done."

echo "Copying config files..."
mkdir -p "$HOME/.config"
cd config
for f in *; do
	rm -rf "$HOME/.config/$f"
	cp -r "$f" "$HOME/.config/$f"
done
cd ..
echo "Done."

echo "Copying executables..."
mkdir -p "$HOME/bin"
cd bin
for f in *; do
	rm -rf "$HOME/bin/$f"
	cp -r "$f" "$HOME/bin/$f"
done
cd ..
echo "Done."

echo "Copying assets..."
rm -fr "$HOME/assets"
cp -r assets "$HOME/assets"
echo "Done."

while getopts :m option; do
	case "$option" in
	m)
		echo "Not switching mod and alt keys."
		echo "" > ~/.Xmodmaprc
		;;
	*)
		echo "Unknown option: $option"
		;;
	esac
done

if [ "$SHELL" != "/bin/zsh" ]; then
	sudo chsh "$USER" -s /bin/zsh
fi

echo "Everything set up!"
