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
function download_my_github_repos () {
    GITHUB_TOKEN=$(git config --global github.token)
    [ -z "$GITHUB_TOKEN" ] && {
        echo "${BIRed}GITHUB_TOKEN is empty${Color_Off}"; return 1; 
    } || {
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/ixicale/RepoLoader/main/exec.sh)";
    }
}
function pull_repo_loggin() {
    repo=${1:-"."}
    option=${2:-"-"}
    [ ! -d "$repo" ] && { return; } || { repo=$(realpath "$repo"); }

    # Get some information about the repository and the last commit
    current_branch=$(cd "$repo" && git branch --show-current)
    last_commit_user=$(cd "$repo" && git log -1 --pretty=format:'%an')
    last_commit_message=$(cd "$repo" && git log -1 --pretty=format:'%s')

    # Use a subshell to redirect all output to the logger file
    (
        echo -e "## Updating ${repo}"
        echo -e "\n> Last commit on branch '$current_branch' by '$last_commit_user'"
        echo -e "> Last commit message: '$last_commit_message'\n"
        cd "$repo" 
        echo -e "\`\`\`"
        # Check if there are any changes to stash
        if [[ -n $(git status --porcelain) ]]; then
            echo -e "\nStashing changes..."
            git stash save --include-untracked "Auto-stash changes before updating"
        fi
        # if main branch exists, checkout to origin/main, else if master branch exists, checkout to origin/master
        if [[ $(git branch --list origin/main) ]]; then
            git checkout origin/main
        elif [[ $(git branch --list origin/master) ]]; then
            git checkout origin/master
        fi
        # Fetch all updates and prune any stale remote branches
        echo -e "\nFetching updates..."
        git fetch --all --prune
        # if current_brach is not empty, pull current_branch changes
        if [[ -n "$current_branch" ]]; then
            # Pull the updates and tags forcefully
            echo -e "\nPulling updates..."
            git pull --force --tags
        fi
        # Check if any stashed changes need to be popped
        if [[ -n $(git stash list) ]]; then
            echo -e "\nPopping stashed changes..."
            git stash pop
        fi
        # Clean up any untracked files and directories
        echo -e "\nCleaning up untracked files and directories..."
        git clean -dfx
        echo -e "\`\`\`\n"

        # Delete local branches if option == restore
        if [[ "$option" == "restore" ]]; then
            echo -e "### Deleting local branches\n\`\`\`"
            echo -e "\nRunning 'git branch | grep -v \"^$current_branch$\" | xargs git branch -D'\n"
            (cd "$repo" && git branch | grep -v "^$current_branch$" | xargs git branch -D)
            echo -e "\`\`\`\n"
        fi
    ) >> "$LOGGER_FILE" 2>&1
}
function pull_repos() {
    folder=${1:-"."}
    option=${2:-"-"}
    [ ! -d "$folder" ] && { 
        echo -e "${BIRed}Folder '$folder' does not exist${Color_Off}";
        return; 
    } || { folder=$(realpath "$folder"); }

    [ -d "$folder/.git" ] && {
        # If folder is a repository, pull it
        echo -e "${BIGreen}Pulling repository '$folder'${Color_Off}"
        pull_repo_loggin "$folder" "$option"
        return; 
    } || [ -d "$folder" ] && {
        # If folder contains repositories, pull all of them
        echo -e "# Pulling all repositories in '$folder' @ $(date '+%Y-%m-%d %H:%M:%S')" > "$LOGGER_FILE"
        find "$folder" -mindepth 2 -maxdepth 2 -type d -name '.git' -print0 | while read -d $'\0' gitdir; do
            pull_repo_loggin "$(dirname "$gitdir")" "$option"
            echo -ne "${BIGreen}."
        done
        echo "DONE!${Color_Off}"
        # Open the log file in the default text editor
        editor "$LOGGER_FILE"
        return; 
    } || {
        echo -e "Usage: pull_repos <folder> [restore]\n\n<folder> can be a repository or a directory containing repositories.\nIf [restore] is specified, all local branches except the current one will be deleted after pulling.\n"
    }
}
function sudo_update() { sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y; }
function reload_this_file () {
    curl -fsSL https://raw.githubusercontent.com/ixicale/tools/main/ubuntu/shell.settings.sh > $SHELL_FILE
    echo "updated $SHELL_FILE"
}
#endregion — — — — — — — — — — # ! FUNCTIONS

#region    — — — — — — — — — — #! EXTENSIONS
# extends more settings from another file EG: 'source $HOME/another_settings_file.sh'
source $SHELL_FOLDER/shell.colors.sh

#endregion — — — — — — — — — — # ! EXTENSIONS

#region    — — — — — — — — — — #! AUTO-RUN SETTINGS
if (($N_DAY == 1)); then
    # each monday (day 1).
    reload_this_file;
elif (($N_DAY == 3)); then
    # wednesday (day 3).
    echo "${BIYellow}Today is Wednesday!!${BGreen}";
    apt moo moo;
    echo "${Color_Off}";
    # sudo_update
else
    # another stuff
fi
#endregion — — — — — — — — — — #! AUTO-RUN SETTINGS

echo "own settings initialized from ${UPurple}'$SHELL_FILE'${Color_Off}"
