#region    — — — — — — — — — — # ! EXPORTS
export N_DAY=$(date +"%u")
export F_DATE=$(date +%Y.%m%b.%d)
export SHELL_FILE="$0"
export SHELL_FOLDER=$(dirname $SHELL_FILE)
export LOGGER_FILE="/tmp/logger_file.md"

#endregion — — — — — — — — — — # ! EXPORTS

#region    — — — — — — — — — — # ! ALIASES
alias  gic="git checkout"
alias  gis="git status; git show;"
alias gime="git merge"
alias gipl="git pull"
alias gips="git push"
alias la="ls -la"
alias ld="ls -d */ | cut -f1 -d'/'" # list directories
alias pipinstall="pip install --ignore-installed --no-cache-dir"
alias editor="code"
#endregion — — — — — — — — — — # ! ALIASES

#region    — — — — — — — — — — # ! FUNCTIONS
function omae_wa_mou_shindeiru() { [[ -z "$1" || ! -d "$1" ]] && { echo "$1 ..." } || { echo -e "${Color_Off}$1_killer says: ${BRed}Omae wa mou shindeiru...${Color_Off}\n$1 says: ${BYellow}Nani!?${Color_Off}"; rm -rf $1; } && echo "----\n"; }
function path_add() { if [ -d "$1" ] && [ -f "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then; { PATH="${PATH:+"$PATH:"}$1" && echo "added $1 to PATH"; }; fi }
function python_venv(){omae_wa_mou_shindeiru $1; python3.7 -m venv $1 && source $1/bin/activate && pip install --upgrade pip; }
function pull_repos_from_folder() {
    [ -d "$1" ] && {
        echo -ne "";
        for repo in $(ls -d $1/*/); do 
            echo -e "## UPDATE $repo\n" >> $LOGGER_FILE;
            cd $repo;
            gic develop &>> $LOGGER_FILE;
            git fetch --all &>> $LOGGER_FILE;
            gipl --tags -f &>> $LOGGER_FILE;
            gipl &>> $LOGGER_FILE;
            echo "" >> $LOGGER_FILE;
            echo -ne "${BIGreen}.";
        done
        echo "DONE!${Color_Off}"
        editor $LOGGER_FILE;
    }
}
function rst () { clear -x; source ~/.zshrc; apt moo moo; echo "";}
#endregion — — — — — — — — — — # ! FUNCTIONS

#region    — — — — — — — — — — #! EXTENSIONS
# extends more settings from another file EG: 'source $HOME/another_settings_file.sh'
source $SHELL_FOLDER/shell.colors.sh
# extends this base settings from another file EG: 'source $HOME/another_settings_file.sh'
#endregion — — — — — — — — — — # ! EXTENSIONS

#region    — — — — — — — — — — #! AUTO-RUN SETTINGS
if (($N_DAY == 3)); then
    # doing something each wednesday (day 3). eg:
    echo "${BIYellow}Today is Wednesday!!${BGreen}";
    apt moo moo;
    echo "${Color_Off}";
else  
    # another stuff
fi
#endregion — — — — — — — — — — #! AUTO-RUN SETTINGS

echo "own settings initialized from ${UPurple}'$SHELL_FILE'${Color_Off}"
