# Windows Subsystem for Linux (WSL)

## Step 1: Open a terminal window

Open Command Prompt as administrator. Or you can open Windows Powershell

## Step 2: Install WSL

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

## Step 3: Restart your computer

Restart your computer to finish installation on Windows.

---

## Step 5: [OPTIONAL] Customize your distro using my settings

Follow the instructions in the README.md file in the `tools/<distro_name>/` directory.

Distro available:

* [UBUNTU](../ubuntu/README.md)
