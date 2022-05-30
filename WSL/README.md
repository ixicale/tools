# Windows Subsystem for Linux (WSL)

## Setup

### Step 1: Open a terminal window

Open Command Prompt as administrator. Or you can open Windows Powershell

### Step 2: Install WSL

Install WSL with specific distro.

```ps
wsl --install -d <DISTRO_NAME>
```

Display all distros available for installation.

```ps
wsl --list --online
```

Pick the distro you want to install. For example,

```ps
wsl --install -d Ubuntu-20.04
```

Or install default distro

```ps
wsl --install
```

### Step 3: Restart your computer

Restart your computer to finish installation on Windows.

---

### Step 5: [OPTIONAL] Customize your distro using my settings

Follow the instructions in the README.md file in the `tools/<distro_name>/` directory.

My distro settings available:

* [UBUNTU](../ubuntu/README.md)

## Backup (export)

### Step 1: Open start on Windows

### Step 2: Search for command prompt

Right click on the command prompt and run as administrator.

### Step 3: Determine the available Linux distros

```ps
wsl --list
```

### Step 4: Backup your distro

```ps
wsl --export <DISTRO_NAME> <BACKUP_FILE.tar>
```

In the command, change `<DISTRO_NAME>` and `<BACKUP_FILE.tar>` with the information for your distribution. If you don’t specify a path, the backup will be stored in the root of “C:”.

For example,

```ps
wsl --export Ubuntu-20.04 C:\ubuntu-20.04.backup.tar
```

## Restore (import)

### Step 1: Open start

### Step 2: Open command prompt as administrator

### Step 3: Restore your distro

```ps
wsl --import <DISTRO-NAME> <INSTALL-LOCATION> <PATH\FILE-NAME.tar>
```

In the command, change `<DISTRO_NAME>`, `<INSTALL-LOCATION>`, and `<PATH\FILE-NAME.tar>` with the information for your distribution.

For example,

```ps
wsl --import Ubuntu-20.04.restored C:\Users\USERNAME\Distros C:\ubuntu-20.04.backup.tar
```

### Step 4: Verify the restoration

```ps
wsl --list
```

### Step 5: Launch your distro

```ps
wsl --distribution <DISTRO_NAME>
```
