# BigGNOMETokyo

**BigGNOMETokyo** is a script to customize the GNOME environment on BigLinux Community or Manjaro with the **Tokyonight-Dark** theme, including icons, cursors, and appearance settings. It also creates backups of existing configurations to ensure safety and easy restoration.

---

## 📋 Requirements

Before running the script, ensure your system meets the following requirements:

- **Operating System**: BigLinux Community or Manjaro with GNOME.
- **Dependencies**:
  - `tar` with `zstd` (Zstandard) support.
  - Superuser permissions (`sudo`).

Install the required dependencies if not already available:

### Usage:

```bash
git clone https://github.com/leoberbert/BigGNOMETokyo.git

cd BigGNOMETokyo

chmod +x customize-gnome.sh

./customize-gnome.sh

```

### 🔄 Backup:

The script creates backups of the following:

- **Icons**: `/usr/share/icons`
- **GTK themes**:
  - `~/.config/gtk-3.0`
  - `~/.config/gtk-4.0`

It also saves the current GNOME settings, including:

- Cursor theme
- Icon theme
- Shell theme
- GTK theme

---

### 🎨 Screenshot:

![image](https://github.com/user-attachments/assets/1cb7a8bb-8467-4cdc-bbd0-1020e5998a90)


---

### 🎨 Configuration:

The script extracts and installs the following:

- **Icon theme**: `Tokyonight-Dark-Icons`
- **GTK theme**: `Tokyonight-Dark-Theme`
- **Cursor theme**: `Nordic-cursors`

After installation, it configures GNOME to use the new themes and cursors.


## 💾 Backups

Backups are stored in the directory:

```bash
$HOME/backup_customizations
```

Each backup includes a timestamp for easy identification. You can use the backups to restore your previous configurations.
