#!/usr/bin/env bash
#
# Script Name: customize-gnome.sh
# Author: Leonardo Berbert
# Created on: 2024-12-19
# Version: 1.0
# Description: This script customizes GNOME by applying themes, icons, and cursors, 
#              while creating backups of existing configurations.
#
# License: All rights reserved by Leoberbert.
#          Redistribution or modification of this script is not allowed 
#          without explicit permission from the author.
#
# Usage: Run this script to apply TokyoNight-Dark theme and related customizations.
#        Example: ./customize-gnome.sh
#

ICONS_DIR="/usr/share/icons"
THEMES_DIR="/usr/share/themes"
GTK4_DIR="$HOME/.config/gtk-4.0"
GTK3_DIR="$HOME/.config/gtk-3.0"
BACKUP_DIR="$HOME/backup_customizations"
SETTINGS_BACKUP="$BACKUP_DIR/gsettings-backup-$(date +%Y%m%d%H%M%S).txt"

# Create a backup directory
mkdir -p "$BACKUP_DIR"
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Failed to create backup directory. Exiting..."
    exit 1
fi

# Backup function
backup_directory() {
    local dir="$1"
    local backup_path="$BACKUP_DIR/$(basename "$dir")-$(date +%Y%m%d%H%M%S).tar.gz"
    
    if [ -d "$dir" ]; then
        echo "Backing up $dir to $backup_path"
        tar -czf "$backup_path" -C "$(dirname "$dir")" "$(basename "$dir")"
    else
        echo "Directory $dir does not exist. Skipping backup."
    fi
}

# Backup GSettings configuration
echo "Backing up current GNOME settings to $SETTINGS_BACKUP..."
{
    echo "cursor-theme: $(gsettings get org.gnome.desktop.interface cursor-theme)"
    echo "icon-theme: $(gsettings get org.gnome.desktop.interface icon-theme)"
    echo "shell-theme: $(gsettings get org.gnome.shell.extensions.user-theme name)"
    echo "gtk-theme: $(gsettings get org.gnome.desktop.interface gtk-theme)"
} > "$SETTINGS_BACKUP"

# Backup and update icons
if [ ! -d "$ICONS_DIR/Tokyonight-Dark-Icons" ]; then
    echo "Directory $ICONS_DIR/Tokyonight-Dark-Icons not found. Extracting..."
    sudo tar -I zstd -xf Tokyonight-Dark-Icons.tar.zst -C "$ICONS_DIR"
else
    echo "Directory $ICONS_DIR/Tokyonight-Dark-Icons already exists. Skipping..."
fi

if [ ! -d "$THEMES_DIR=Tokyonight-Dark-Theme" ]; then
    echo "Directory $THEMES_DIR/Tokyonight-Dark-Theme not found. Extracting..."
    sudo tar -I zstd -xf Tokyonight-Dark-Theme.tar.zst -C "$THEMES_DIR"
else
    echo "Directory $THEMES_DIR/Tokyonight-Dark-Theme already exists. Skipping..."
fi

if [ ! -d "$ICONS_DIR/Nordic-cursors" ]; then
    echo "Directory $ICONS_DIR/Nordic-cursors not found. Extracting..."
    sudo tar -I zstd -xf Nordic-cursors.tar.zst -C "$ICONS_DIR"
else
    echo "Directory $ICONS_DIR/Nordic-cursors already exists. Skipping..."
fi

# Backup and update GTK 4 configuration
if [ -d "$GTK4_DIR" ]; then
    echo "Directory $GTK4_DIR already exists. Backing up..."
    backup_directory "$GTK4_DIR"
else
    echo "Directory $GTK4_DIR not found. Creating..."
    mkdir -p "$GTK4_DIR"
fi
cp -rp $THEMES_DIR/Tokyonight-Dark-Theme/gtk-4.0/* $GTK4_DIR/

# Backup and update GTK 3 configuration
if [ -d "$GTK3_DIR" ]; then
    echo "Directory $GTK3_DIR already exists. Backing up..."
    backup_directory "$GTK3_DIR"
else
    echo "Directory $GTK3_DIR not found. Creating..."
    mkdir -p "$GTK3_DIR"
fi
cp -rp $THEMES_DIR/Tokyonight-Dark-Theme/gtk-3.0/* $GTK3_DIR/

# Apply new GNOME settings
echo "Applying new GNOME settings..."
gsettings set org.gnome.desktop.interface cursor-theme 'Nordic-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'Tokyonight-Dark-Icons'
gsettings set org.gnome.shell.extensions.user-theme name 'Tokyonight-Dark-Theme'
gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark-Theme'
gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/wallpapers/space-planet-blue-and-purple.avif'

echo "Process completed. GNOME settings updated."
