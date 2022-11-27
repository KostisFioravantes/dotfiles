: ${HOME:?"missing environment variable"}
: ${XDG_STATE_HOME:="$HOME/.local/state"}
: ${XDG_DATA_HOME:="$HOME/.local/share"}
: ${XDG_CONFIG_HOME:="$HOME/.config"}
: ${XDG_CACHE_HOME:="$HOME/.cache"}
: ${ZDOTDIR:="$HOME"}

# Dirstack
DIRSTACKSIZE=10
setopt	AUTO_PUSHD\
	PUSHD_IGNORE_DUPS

# History
SAVEHIST=100000
HISTSIZE=$SAVEHIST
HISTFILE="$XDG_CACHE_HOME/.zsh_history"
setopt	APPEND_HISTORY\
	HIST_SAVE_NO_DUPS\
	HIST_REDUCE_BLANKS\
	HIST_IGNORE_ALL_DUPS

# Prompt
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats\
	$'%F{white}(%F{green}%b %F{yellow}\uE0A0%F{white})'
precmd()
{
	print -P "%(?.%F{green}\u2714.%F{red}\u2718)"
	PS1=$'\n%F{blue}%/\n${vcs_info_msg_0_}%F{white}$ '
	vcs_info 
}

# If buffer is empty, then don't accept line.
accept-line() zle ${BUFFER:+".accept-line"}
zle -N accept-line

# Go backward during completion with shift+tab.
bindkey -M viins '^[[Z' reverse-menu-complete

unsetopt NOMATCH
setopt GLOB_COMPLETE
_comp_options+=(globdots)

setopt	INTERACTIVE_COMMENTS

for file in\
	"$ZDOTDIR/vi_emulation.zsh"\
	"$XDG_DATA_HOME/zsh/colors.sh"\
	"$XDG_DATA_HOME/zsh/regexs.sh"\
	"$XDG_DATA_HOME/zsh/aliases.sh"
do source $file
done

zstyle ':completion:*' list-colors $LS_COLORS

fpath=(
	"$XDG_DATA_HOME/zsh/functions/Auto_Pairs"
	$fpath
)

autoload -RUz autopair-init
autopair-init

