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
alias gimme="git merge"
alias gipl="git pull"
alias gips="git push"
alias la="ls -la"
alias ld="ls -d */ | cut -f1 -d'/'" # list directories
alias pipinstall="pip install --ignore-installed --no-cache-dir"
alias editor="code"
#endregion — — — — — — — — — — # ! ALIASES

#region    — — — — — — — — — — # ! FUNCTIONS
function omae_wa_mou_shindeiru() { [[ -z "$1" || ! -d "$1" ]] && { echo "$1 ..." } || { echo -e "${Color_Off}$1_killer says: ${BRed}Omae wa mou shindeiru...${Color_Off}\n$1 says: ${BYellow}Nani!?${Color_Off}"; rm -rf $1; } && echo "----\n"; }
function path_add() { if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then; { PATH="${PATH:+"$PATH:"}$1" && echo "added $1 to PATH"; }; fi }
function python_venv(){omae_wa_mou_shindeiru $1; python3.7 -m venv $1 && source $1/bin/activate && pip install --upgrade pip; }
function git_logging() {
    repo=${1:-"."}
    option=${2:-"-"}

    # Get some information about the repository and the last commit
    current_branch=$(cd "$repo" && git branch --show-current)
    last_commit_user=$(cd "$repo" && git log -1 --pretty=format:'%an')

    # Log the update message and the commands to be executed
    echo -e "## UPDATE $repo\n\`\`\`" >> "$LOGGER_FILE"
    (
        cd "$repo"
        # Stash changes if there are any
        [ -n "$(git status --porcelain)" ] && git stash >> "$LOGGER_FILE" 2>&1
        git fetch --all 
        git remote prune origin 
        git pull --force --tags
        # Pop the stash if changes were stashed
        [ -n "$(git stash list)" ] && git stash pop >> "$LOGGER_FILE" 2>&1
    ) >> "$LOGGER_FILE" 2>&1
    echo -e "\`\`\`\n> Last commit on branch '$current_branch' by '$last_commit_user'\n" >> "$LOGGER_FILE"

    # Delete local branches if option == del_local_branches
    if [ "$option" == "del_local_branches" ]; then
        echo -e "### Deleting local branches\n\`\`\`" >> "$LOGGER_FILE"
        (cd "$repo" && git branch | grep -v "^$current_branch$" | xargs git branch -D) >> "$LOGGER_FILE" 2>&1
        echo -e "\`\`\`\n" >> "$LOGGER_FILE"
    fi
    }

function pull_repos() {
    folder=${1:-"."}
    option=${2:-"-"}
    [ -d "$folder/.git" ] && {
        # If folder is a repository, pull it
        echo -e "${BIGreen}Pulling repository '$repo'${Color_Off}"
        git_logging "$folder" "$option"
    } || [ -d "$folder" ] && {
        # If folder contains repositories, pull all of them
        echo -e "Pulling all repositories in '$folder'\n# $(date '+%Y-%m-%d %H:%M:%S')" > "$LOGGER_FILE"
        find "$folder" -mindepth 2 -maxdepth 2 -type d -name '.git' -print0 | while read -d $'\0' gitdir; do
            git_logging "$(dirname "$gitdir")" "$option"
            echo -ne "${BIGreen}."
        done
        echo "DONE!${Color_Off}"
        # Open the log file in the default text editor
        editor "$LOGGER_FILE"
    } || {
        echo -e "Usage: pull_repos <folder> [del_local_branches]\n\n<folder> can be a repository or a directory containing repositories.\nIf [del_local_branches] is specified, all local branches except the current one will be deleted after pulling.\n"
    }
}
function rst () { clear -x; source ~/.zshrc; apt moo moo; echo "";}
function sudo_update() { sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y; }
#endregion — — — — — — — — — — # ! FUNCTIONS

#region    — — — — — — — — — — #! EXTENSIONS
# extends more settings from another file EG: 'source $HOME/another_settings_file.sh'
source $SHELL_FOLDER/shell.colors.sh

#endregion — — — — — — — — — — # ! EXTENSIONS

#region    — — — — — — — — — — #! AUTO-RUN SETTINGS
if (($N_DAY == 3)); then
    # doing something each wednesday (day 3). eg:
    echo "${BIYellow}Today is Wednesday!!${BGreen}";
    apt moo moo;
    echo "${Color_Off}";
    # sudo_update
else
    # another stuff
fi
#endregion — — — — — — — — — — #! AUTO-RUN SETTINGS

echo "own settings initialized from ${UPurple}'$SHELL_FILE'${Color_Off}"
