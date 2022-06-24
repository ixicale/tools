# fino-time.zsh-theme

# Use with a dark background and 256-color terminal!
# Meant for people with RVM and git. Tested only on OS X 10.7.

# You can set your computer name in the ~/.box-name file if you want.

# Borrowing shamelessly from these oh-my-zsh themes:
#   bira
#   robbyrussell
#
# Also borrowing from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/


########## COLOR ###########
for COLOR in CYAN WHITE YELLOW MAGENTA BLACK BLUE RED DEFAULT GREEN GREY; do
  eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
  eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

PR_RESET="%{$reset_color%}"
RED_START="${PR_RESET}${PR_GREY}<${PR_RESET}${PR_RED}<${PR_BRIGHT_RED}<${PR_RESET} "
RED_END="${PR_RESET}${PR_BRIGHT_RED}>${PR_RESET}${PR_RED}>${PR_GREY}>${PR_RESET} "
GREEN_END="${PR_RESET}${PR_BRIGHT_GREEN}>${PR_RESET}${PR_GREEN}>${PR_GREY}>${PR_RESET} "
GREEN_BASE_START="${PR_RESET}${PR_GREY}>${PR_RESET}${PR_GREEN}>${PR_BRIGHT_GREEN}>${PR_RESET}"
GREEN_START_P1="${PR_RESET}${GREEN_BASE_START}${PR_RESET} "
DIVISION="${PR_RESET}${PR_RED} < ${PR_RESET}"
VCS_DIRTY_COLOR="${PR_RESET}${PR_YELLOW}"
VCS_CLEAN_COLOR="${PR_RESET}${PR_GREEN}"
VCS_SUFIX_COLOR="${PR_RESET}${PR_CYAN}› ${PR_RESET}"

function virtualenv_prompt_info {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "\
$PR_CYAN$PR_HBAR$PR_BLUE(\
${PR_MAGENTA}${ZSH_THEME_VIRTUALENV_PREFIX:=}\
${${VIRTUAL_ENV%/*}##*/}/\
${VIRTUAL_ENV:t}\
${ZSH_THEME_VIRTUALENV_SUFFIX:=}\
${PR_BLUE})${PR_CYAN}$PR_HBAR\
${PR_RESET}"
}
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo "⠠⠵" && return echo "○"
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo ${SHORT_HOST:-$HOST}
}
function prompt_workspace {
    echo "%{$terminfo[bold]${PR_BLUE}%~${PR_WHITE}"
}
function prompt_user_host {
    echo "%{$FG[040]%}%n${PR_RESET}${PR_GREY}@%{$FG[033]%}$(box_name)${PR_RESET}"
}
function prompt_timestamp {
    echo "%D{%a %b %d %Y} ${PR_WHITE}%* ${PR_RESET}"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1


#region
functions rbenv_prompt_info >& /dev/null || rbenv_prompt_info(){}

function theme_precmd {
    local TERMWIDTH
    local aux_fix=0 # fix for prompt size
    (( TERMWIDTH = ${COLUMNS} - ${aux_fix} ))


    ###
    # Truncate the path if it's too long.

    PR_FILLBAR=""
    PR_PWDLEN=""

    local promptsize=${#${(%):---(%n@%m:%l)---()--}}
    local rubyprompt=`rvm_prompt_info || rbenv_prompt_info`
    local rubypromptsize=${#${rubyprompt}}
    local pwdsize=${#${(%):-%~}}

    if [[ "$promptsize + $rubypromptsize + $pwdsize" -gt $TERMWIDTH ]]; then
      ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
      PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $rubypromptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi

}


setopt extended_glob
theme_preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload zsh/terminfo
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
      eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
      eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
      (( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    ###
    # Modify Git prompt
    ZSH_THEME_GIT_PROMPT_PREFIX="${PR_CYAN}$PR_HBAR${PR_BLUE}(${PR_GREEN}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="${PR_BLUE})${PR_CYAN}$PR_HBAR${PR_RESET}"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    ZSH_THEME_GIT_PROMPT_ADDED="${PR_GREEN} ✚${PR_RESET}"
    ZSH_THEME_GIT_PROMPT_MODIFIED="${PR_BLUE} ✹${PR_RESET}"
    ZSH_THEME_GIT_PROMPT_DELETED="${PR_RED} ✖${PR_RESET}"
    ZSH_THEME_GIT_PROMPT_RENAMED="${PR_MAGENTA} ➜${PR_RESET}"
    ZSH_THEME_GIT_PROMPT_UNMERGED="${PR_YELLOW} ═${PR_RESET}"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="${PR_CYAN} ✭${PR_RESET}"

    ###
    # See if we can use extended characters to look nicer.
    # UTF-8 Fixed

    if [[ $(locale charmap) == "UTF-8" ]]; then
      PR_SET_CHARSET=""
      PR_SHIFT_IN=""
      PR_SHIFT_OUT=""
      PR_HBAR="─"
      PR_ULCORNER="┌"
      PR_LLCORNER="└"
      PR_LRCORNER="┘"
      PR_URCORNER="┐"
    else
      typeset -A altchar
      set -A altchar ${(s..)terminfo[acsc]}
      # Some stuff to help us draw nice lines
      PR_SET_CHARSET="%{$terminfo[enacs]%}"
      PR_SHIFT_IN="%{$terminfo[smacs]%}"
      PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
      PR_HBAR='$PR_SHIFT_IN${altchar[q]:--}$PR_SHIFT_OUT'
      PR_ULCORNER='$PR_SHIFT_IN${altchar[l]:--}$PR_SHIFT_OUT'
      PR_LLCORNER='$PR_SHIFT_IN${altchar[m]:--}$PR_SHIFT_OUT'
      PR_LRCORNER='$PR_SHIFT_IN${altchar[j]:--}$PR_SHIFT_OUT'
      PR_URCORNER='$PR_SHIFT_IN${altchar[k]:--}$PR_SHIFT_OUT'
    fi


    ###
    # Decide if we need to set titlebar text.

    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac


    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	PR_STITLE=''
    fi


    ###
    # Finally, the prompt.

    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_ULCORNER$PR_HBAR$PR_GREY(\
$PR_WHITE%$PR_PWDLEN<......<%d%<<\
$PR_GREY)`rvm_prompt_info || rbenv_prompt_info`\
$PR_CYAN$PR_HBAR${(e)PR_FILLBAR}$PR_HBAR$PR_GREY(\
`prompt_user_host`\
$PR_GREY)$PR_CYAN$PR_HBAR$PR_URCORNER\

$PR_CYAN$PR_LLCORNER\
$PR_CYAN$PR_HBAR\
\
$PR_BLUE(\
$PR_YELLOW%D{%H:%M:%S}\
$PR_BLUE)\
$PR_CYAN$PR_HBAR\
\
$PR_LIGHT_BLUE%{$reset_color%}`git_prompt_info``git_prompt_status`\
\
$PR_CYAN\
➢\
$PR_WHITE  '

    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"
    RPROMPT=' $return_code$PR_CYAN$PR_HBAR\
`virtualenv_prompt_info`\
$PR_CYAN$PR_LRCORNER$PR_WHITE'

    PS2='$PR_CYAN$PR_HBAR\
$PR_BLUE$PR_HBAR(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_HBAR\
$PR_CYAN$PR_HBAR$PR_WHITE '
}

setprompt

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
add-zsh-hook preexec theme_preexec

#endregion