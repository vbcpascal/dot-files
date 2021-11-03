# Sunrise theme for oh-my-zsh
# Intended to be used with Solarized: https://ethanschoonover.com/solarized

# Color shortcuts
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo ${SHORT_HOST:-$HOST}
}

ZSH_THEME_STR_HOST="Ubuntu" # $(box_name)
ZSH_THEME_STR_USER="%n"

SUCC_PROMPT_SYMBOL="(๑ •ㅂ•)"
FAIL_PROMPT_SYMBOL="[σ｀д′]σ"

ZSH_THEME_COLOR_STRUCT="$FG[008]"
ZSH_THEME_COLOR_HOST="$fg_bold[blue]"
ZSH_THEME_COLOR_USER="$fg_bold[yellow]"
ZSH_THEME_COLOR_PWD="$fg_bold[green]"
ZSH_THEME_COLOR_GIT="$fg_bold[cyan]"

R="$fg_bold[red]"

# if [ "$USER" = "root" ]; then
#     PROMPTCOLOR="%{$R%}" PROMPTPREFIX="-!-";
# else
#     PROMPTCOLOR="" PROMPTPREFIX="---";
# fi

# write the first line
PROMPT="%{$ZSH_THEME_COLOR_STRUCT%}╭─ "

# write the user name
PROMPT+="%{$ZSH_THEME_COLOR_USER%}$ZSH_THEME_STR_USER "

# write the device name
if [ -n "$ZSH_THEME_STR_HOST" ]; then
    PROMPT+="%{$ZSH_THEME_COLOR_STRUCT%}at "
    PROMPT+="%{$ZSH_THEME_COLOR_HOST%}$ZSH_THEME_STR_HOST "
fi

# write the directory
PROMPT+="%{$ZSH_THEME_COLOR_STRUCT%}in "
PROMPT+="%{$ZSH_THEME_COLOR_PWD%}%~ "

PROMPT+='$(git_prompt_info)'

# Write the second line
PROMPT+="
%{$ZSH_THEME_COLOR_STRUCT%}╰─ "

# Write emoji
PROMPT+="%(?:%{$ZSH_THEME_COLOR_STRUCT%}$SUCC_PROMPT_SYMBOL :%{$ZSH_THEME_COLOR_STRUCT%}$FAIL_PROMPT_SYMBOL )"
PROMPT+="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$ZSH_THEME_COLOR_STRUCT%}on %{$ZSH_THEME_COLOR_GIT%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="* "
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_AHEAD="%{$B%}➔"

ZSH_THEME_GIT_STATUS_PREFIX=" "

# Staged
ZSH_THEME_GIT_PROMPT_STAGED_ADDED="%{$G%}A"
ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED="%{$G%}M"
ZSH_THEME_GIT_PROMPT_STAGED_RENAMED="%{$G%}R"
ZSH_THEME_GIT_PROMPT_STAGED_DELETED="%{$G%}D"

# Not-staged
ZSH_THEME_GIT_PROMPT_UNTRACKED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="~"
ZSH_THEME_GIT_PROMPT_DELETED="-"
ZSH_THEME_GIT_PROMPT_UNMERGED="!"
