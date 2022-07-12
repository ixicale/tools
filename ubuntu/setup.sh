#!/bin/bash
# Script to download my initial stuff
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/setup.sh)"
# or via wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/setup.sh)"
# or via fetch:
#   sh -c "$(fetch -o - https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/setup.sh)"
#
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/setup.sh
#   sh setup.sh
# 
DOWNLOAD_CONTAINER="$HOME/.xide";

setup_color(){
    # Regular Colors

    PR_RESET=$(printf '\033[0m'    )  # Text Reset
    PR_BLACK=$(printf '\033[0;30m' )  # Black
    PR_RED=$(printf '\033[0;31m'   )  # Red
    PR_GREEN=$(printf '\033[0;32m' )  # Green
    PR_YELLOW=$(printf '\033[0;33m')  # Yellow
    PR_BLUE=$(printf '\033[0;34m'  )  # Blue
    PR_PURPLE=$(printf '\033[0;35m')  # Purple
    PR_CYAN=$(printf '\033[0;36m'  )  # Cyan
    PR_WHITE=$(printf '\033[0;37m' )  # White
    PR_RAINBOW="
        $PR_YELLOW
        $PR_BLUE
        $PR_PURPLE
        $PR_RED
        $PR_GREEN
    "
}
print_success(){
    setup_color
    printf "%s                      %s        %s           ddddddd %s                %s ────────────────────────────────────────────────────────────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%sXXXXXXX       XXXXXXX %s  iii   %s           d:::::d %s                %s ──╔════╦╗─────────────────╔╗────────────────────────────────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%sX:::::X       X:::::X %s i:::i  %s           d:::::d %s                %s ──║╔╗╔╗║║─────────────────║║────────────────────────────────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%sX:::::X       X:::::X %s  iii   %s           d:::::d %s                %s ──╚╝║║╚╣╚═╦══╗ ╔══╦══╦══╦═╝║ ╔╗╔╗╔╦══╦══╗───────────────────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%sX::::::X     X::::::X %s        %s           d::::d  %s                %s ────║║─║╔╗║║═╣ ║══╣║═╣║═╣╔╗║ ║╚╝╚╝║╔╗║══╣───────────────────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%sXXX:::::X   X:::::XXX %siiiiii  %s    dddddddd::::d  %s    eeeeeeee    %s ────║║─║║║║║═╣ ╠══║║═╣║═╣╚╝║ ╚╗╔╗╔╣╔╗╠══║───────────────────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%s   X:::::X X:::::X    %si::::i  %s  dd::::::::::::d  %s  ee::::::::ee  %s ────╚╝─╚╝╚╩══╝ ╚══╩══╩══╩══╝──╚╝╚╝╚╝╚╩══╝───────────────────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%s    X:::::X:::::X     %s i:::i  %s d::::::::::::::d  %s e::::eeeee:::ee%s ────╔╗─────╔╗────────────╔╗────────────────────╔═╗──╔╗╔╗────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%s     X:::::::::X      %s i:::i  %sd::::::ddddd::::d  %se::::e     e:::e%s ────║║─────║║────────────║║────────────────────║╔╝──║║║║────── %s\n" $PR_RAINBOW $PR_RESET
    printf "%s     X:::::::::X      %s i:::i  %sd:::::d    d::::d  %se:::::eeeee::::e%s ──╔═╝╠══╦══╣║╔══╦╗─╔╦══╦═╝║ ╔══╦╗╔╦══╦══╦══╦══╦╝╚╦╗╔╣║║║╔╗─╔╗─ %s\n" $PR_RAINBOW $PR_RESET
    printf "%s    X:::::X:::::X     %s i:::i  %sd::::d     d::::d  %se:::::::::::::e %s ──║╔╗║║═╣╔╗║║║╔╗║║─║║║═╣╔╗║ ║══╣║║║╔═╣╔═╣║═╣══╬╗╔╣║║║║║║║║─║║─ %s\n" $PR_RAINBOW $PR_RESET
    printf "%s   X:::::X X:::::X    %s i:::i  %sd::::d     d::::d  %se::::eeeeeeeee  %s ──║╚╝║║═╣╚╝║╚╣╚╝║╚═╝║║═╣╚╝║ ╠══║╚╝║╚═╣╚═╣║═╬══║║║║╚╝║╚╣╚╣╚═╝║─ %s\n" $PR_RAINBOW $PR_RESET
    printf "%sXXX:::::X   X:::::XXX %s i:::i  %sd::::d     d::::d  %se:::::e         %s ──╚══╩══╣╔═╩═╩══╩═╗╔╩══╩══╝ ╚══╩══╩══╩══╩══╩══╝╚╝╚══╩═╩═╩═╗╔╝─ %s\n" $PR_RAINBOW $PR_RESET
    printf "%sX::::::X     X::::::X %si:::::i %sd:::::ddddd:::::dd %se::::::e        %s ────────║║──────╔═╝║────────▄▀▄─────▄▀▄─────────────────╔═╝║── %s\n" $PR_RAINBOW $PR_RESET
    printf "%sX:::::X       X:::::X %si:::::i %s d:::::::::::::::d %s e::::::eeeeee  %s ────────╚╝──────╚══╝───────▄█░░▀▀▀▀▀░░█▄────────────────╚══╝── %s\n" $PR_RAINBOW $PR_RESET
    printf "%sX:::::X       X:::::X %si:::::i %s  d::::::::ddd:::d %s  ee:::::::::e  %s ───────────────────────▄▄──█░░░░░░░░░░░█──▄▄──────...Thanks!❤️ %s\n" $PR_RAINBOW $PR_RESET
    printf "%sXXXXXXX       XXXXXXX %siiiiiii %s   dddddddd   dddd %s    eeeeeeeeee  %s ──────────────────────█▄▄█─█░░▀░░┬░░▀░░█─█▄▄█───────────────── %s\n" $PR_RAINBOW $PR_RESET
    echo   "Now you are part of the Xide's family because you are downloading 'the seed'."
    echo   "Using 'the seed' is your own responsibilily of all stuff downloaded from here. Now, Enjoy! :)"
}
create_main_container(){
    # delete old stuff
    [ -d "$DOWNLOAD_CONTAINER" ] && { rm -rf "$DOWNLOAD_CONTAINER"; }
    # download new stuff
    mkdir "$DOWNLOAD_CONTAINER";
}
up_to_day(){
    sudo apt -y update;
    sudo apt -y upgrade;
}
setup_package_to_install(){
    sudo apt install git xclip zsh fonts-powerline curl;
    sudo snap install --classic code;
}
download_seed(){
    create_main_container;
    cd "$DOWNLOAD_CONTAINER";
    wget https://raw.githubusercontent.com/ixicale/tools/main/theme/xide.zsh-theme;
    wget https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/shell.settings.sh;
    wget https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/shell.colors.sh;

}
setup_oh_my_zsh(){
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
}

main(){
    up_to_day
    setup_package_to_install
    download_seed
    echo "Version: 2022071201"
    print_success
    setup_oh_my_zsh
}


main