#region    — — — — — — — — — — # ! my exports
export F_DATE=$(date +%Y.%m%b.%d)
export MY_SHELL_FILE="$0"
export MY_SETTINGS_FOLDER=$(dirname $MY_SHELL_FILE)
#endregion — — — — — — — — — — # ! my exports

#region    — — — — — — — — — — # ! my aliases
alias  gic="git checkout"
alias  gis="git status; git show;"
alias gime="git merge"
alias gipl="git pull"
alias gips="git push"
alias la="ls -la"
alias ld="ls -d */ | cut -f1 -d'/'" # list directories
alias pipinstall="pip install --ignore-installed --no-cache-dir"
#endregion — — — — — — — — — — # ! my aliases

#region    — — — — — — — — — — # ! my functions
function omae_wa_mou_shindeiru() { [[ -z "$1" || ! -d "$1" ]] && { echo "$1 ..." } || { echo -e "$1_killer says: omae wa mou shindeiru...\n$1 says: Nani!?"; rm -rf $1; } && echo "----\n"; }
function path_add() { [[ -d "$1" ] && [ -f "$1" ] && [[ ":$PATH:" != *":$1:"* ]]] && { PATH="${PATH:+"$PATH:"}$1" && echo "added $1 to PATH"; } || { echo "not added $1 to PATH"; } }
function python_venv(){omae_wa_mou_shindeiru $1; python3.7 -m venv $1 && source $1/bin/activate && pip install --upgrade pip; }
function pull_repos_from_folder() {
    [ -d "$1" ] && { cd $1 && for repo in $(ls -d */); do echo -e "\n\n## update $repo" && echo "$(cd $repo && gic develop && git fetch --all && gipl --tags -f && gipl)"; done }
}
function rst () { clear -x; source ~/.zshrc; apt moo moo; echo "";}
#endregion — — — — — — — — — — # ! my functions

# extends this base settings from another file EG: 'source /path/to/my/custom/shell_settings_file.sh'

echo "own settings initialized from '$MY_DEVS_FILE'"