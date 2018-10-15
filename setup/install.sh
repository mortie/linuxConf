#!/bin/sh

exists() {
	which "$1" >/dev/null 2>/dev/null
}

init() {
	if exists apt; then
		apt update && apt -y upgrade
	elif exists apt-get; then
		apt-get update && apt-get -y upgrade
	elif exists pacman; then
		pacman --noconfirm -Syu
	else
		echo "No known package manager installed."
		exit 1
	fi
}

install() {
	echo
	echo "Installing $1..."
	if exists apt; then
		apt install -y "$1"
	elif exists apt-get; then
		apt-get install -y "$1"
	elif exists pacman; then
		pacman --noconfirm -S "$1"
	else
		echo "No known package manager installed."
		exit 1
	fi
}

init

install vim
install curl
install zsh
install sshfs
install zsh-syntax-highlighting
install zsh-autosuggestions
