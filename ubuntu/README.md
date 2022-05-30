# Setup Ubuntu distro's tools

## Install

To install "the seed" of the Ubuntu distro tools, run:

### This script should be run via curl

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/setup.sh)";

```

### By wget

```bash
sh -c "$(wget -qO- https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/setup.sh)";

```

### By fetch

```bash
sh -c "$(fetch -o - https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/setup.sh)";

```

### Other methods

```bash
wget https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/setup.sh;
sh setup.sh;

```

## Download shell settings

Only run this if you want to download my shell settings `after the installation of OH-MY-ZSH`:

```bash
# Link my theme to ZSH
ln -nsf $HOME/.xide/xide.zsh-theme $ZSH/themes/xide.zsh-theme;
# Append my custom aliases, functions, and keybindings to ZSH
echo -e "\nsource $HOME/.xide/shell.settings.sh" >> $HOME/.zshrc;
# Reload ZSH
source $HOME/.zshrc;


```
