#!/bin/bash
# Script to download my initial stuff
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ixicale/tools/main/macOs/setup.sh)"
# or via wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/ixicale/tools/main/macOs/setup.sh)"
# or via fetch:
#   sh -c "$(fetch -o - https://raw.githubusercontent.com/ixicale/tools/main/macOs/setup.sh)"
#
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/ixicale/tools/main/macOs/setup.sh
#   sh setup.sh
# 
DOWNLOAD_CONTAINER="$HOME/.xide";

setup_brew(){
    # First, make sure Homebrew is installed on the system
    if ! command -v brew &>/dev/null; then
        echo "Homebrew is not installed. Installing now..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

setup_color(){
    # Regular Colors

    PR_RESET=$(printf '\033[0m')
    PR_BLACK=$(printf '\033[0;30m')
    PR_RED=$(printf '\033[0;31m')
    PR_GREEN=$(printf '\033[0;32m')
    PR_YELLOW=$(printf '\033[0;33m')
    PR_BLUE=$(printf '\033[0;34m')
    PR_PURPLE=$(printf '\033[0;35m')
    PR_CYAN=$(printf '\033[0;36m')
    PR_WHITE=$(printf '\033[0;37m')
}
print_success(){
    setup_color
    printf "%s                    %s       %s       ddddd %s             %s ───────────────────────────────────────────────────────────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sXXXXXX       XXXXXX %s  ii   %s       d:::d %s             %s ─╔════╦╗─────────────────╔╗────────────────────────────────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sX::::X       X::::X %s i::i  %s       d:::d %s             %s ─║╔╗╔╗║║─────────────────║║────────────────────────────────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sX::::X       X::::X %s  ii   %s       d:::d %s             %s ─╚╝║║╚╣╚═╦══╗ ╔══╦══╦══╦═╝║ ╔╗╔╗╔╦══╦══╗───────────────────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sX:::::X     X:::::X %s       %s       d::d  %s             %s ───║║─║╔╗║║═╣ ║══╣║═╣║═╣╔╗║ ║╚╝╚╝║╔╗║══╣───────────────────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sXX:::::X   X:::::XX %siiiii  %s   ddddd::d  %s   eeeeeee   %s ───║║─║║║║║═╣ ╠══║║═╣║═╣╚╝║ ╚╗╔╗╔╣╔╗╠══║───────────────────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%s  X:::::X X:::::X   %si:::i  %s  d:::::::d  %s  e:::::::e  %s ───╚╝─╚╝╚╩══╝ ╚══╩══╩══╩══╝──╚╝╚╝╚╝╚╩══╝───────────────────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%s   X:::::X:::::X    %s i::i  %s d::::::::d  %s e:::eeee::ee%s ───╔╗─────╔╗────────────╔╗────────────────────╔═╗──╔╗╔╗────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%s    X:::::::::X     %s i::i  %sd::::ddd::d  %se:::e    e::e%s ───║║─────║║────────────║║────────────────────║╔╝──║║║║────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%s    X:::::::::X     %s i::i  %sd:::d  d::d  %se::::eeee:::e%s ─╔═╝╠══╦══╣║╔══╦╗─╔╦══╦═╝║ ╔══╦╗╔╦══╦══╦══╦══╦╝╚╦╗╔╣║║║╔╗─╔╗─ %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%s   X:::::X:::::X    %s i::i  %sd::d   d::d  %se::::::::::e %s ─║╔╗║║═╣╔╗║║║╔╗║║─║║║═╣╔╗║ ║══╣║║║╔═╣╔═╣║═╣══╬╗╔╣║║║║║║║║─║║─ %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%s  X:::::X X:::::X   %s i::i  %sd::d   d::d  %se:::eeeeeee  %s ─║╚╝║║═╣╚╝║╚╣╚╝║╚═╝║║═╣╚╝║ ╠══║╚╝║╚═╣╚═╣║═╬══║║║║╚╝║╚╣╚╣╚═╝║─ %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sXX:::::X   X:::::XX %s i::i  %sd::d   d::d  %se::::e       %s ─╚══╩══╣╔═╩═╩══╩═╗╔╩══╩══╝ ╚══╩══╩══╩══╩══╩══╝╚╝╚══╩═╩═╩═╗╔╝─ %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sX:::::X     X:::::X %si::::i %sd:::ddd:::dd %se:::::e      %s ───────║║──────╔═╝║────────▄▀▄─────▄▀▄─────────────────╔═╝║── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sX::::X       X::::X %si::::i %s d:::::::::d %s e:::::eeee  %s ───────╚╝──────╚══╝───────▄█░░▀▀▀▀▀░░█▄────────────────╚══╝── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sX::::X       X::::X %si::::i %s  d::::dd::d %s  e:::::::e  %s ──────────────────────▄▄──█░░░░░░░░░░░█──▄▄──────...Thanks!❤️ %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    printf "%sXXXXXX       XXXXXX %siiiiii %s   dddd  ddd %s   eeeeeeee  %s ─────────────────────█▄▄█─█░░▀░░┬░░▀░░█─█▄▄█───────────────── %s\n" $PR_YELLOW $PR_BLUE $PR_PURPLE $PR_RED $PR_GREEN $PR_RESET
    echo   "Now you are part of the Xide's family because you are downloading 'the seed'."
    echo   "Using 'the seed' is your own responsibilily of all stuff downloaded from here. Now, Enjoy! :)"
}
create_main_container(){
    # delete old stuff
    [ -d "$DOWNLOAD_CONTAINER" ] && { rm -rf "$DOWNLOAD_CONTAINER"; }
    # download new stuff
    mkdir "$DOWNLOAD_CONTAINER";
}

up_to_date() {
    brew update;
    brew upgrade;
}

setup_package_to_install() {
    brew install git wget curl;
    # Installing Visual Studio Code
    brew install --cask visual-studio-code;
}

download_seed(){
    create_main_container;
    cd "$DOWNLOAD_CONTAINER";
    curl -O https://raw.githubusercontent.com/ixicale/tools/main/theme/xide.zsh-theme;
    curl -O https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/shell.settings.sh;
    curl -O https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/shell.colors.sh;
}
setup_oh_my_zsh(){
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
}

main(){
    setup_brew
    up_to_date
    setup_package_to_install
    download_seed
    setup_oh_my_zsh
    print_success
    echo "Version: 2023082601"
}

main
