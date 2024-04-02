: ${USER:="$(/bin/whoami)"}
: ${HOME:="/home/$USER"}
: ${XDG_CACHE_HOME:="$HOME/.cache"}
: ${XDG_CONFIG_HOME:="$HOME/.config"}
: ${XDG_DATA_HOME:="$HOME/.local/share"}
: ${XDG_STATE_HOME:="$HOME/.local/state"}

setopt autocd globcomplete histignorealldups histignorespace histignorespace\
	histreduceblanks histsavenodups interactivecomments menucomplete monitor\
	posixaliases posixtraps promptsubst pushdignoredups sharehistory vi

fpath+=(
	$(/bin/find -L "$XDG_DATA_HOME/zsh/functions"\
		-mindepth 1 -maxdepth 1 -type d 2>/dev/null)
)

() {
	emulate -L zsh
	setopt pathdirs
	. 'Aliases/basics.sh'
	. 'Aliases/listing.zsh'
	. 'Regexps/RFC1738.sh'
	. 'History/history.zsh'
	. 'List_Dir/lscolors.zsh'
}

# Directories List
# ================
DIRSTACKSIZE=20
if autoload -RUz cdr chpwd_recent_dirs; then
	unsetopt autocd pushdignoredups
	chpwd_functions+=(chpwd_recent_dirs)
	zstyle ':chpwd:*' recent-dirs-max $DIRSTACKSIZE
	zstyle ':chpwd:*' recent-dirs-file "$XDG_CACHE_HOME/.chpwd_list"
fi

# Prompt Theme
# ============
PS1=$'%(?.\n.)%F{3}%B\uF109 %b%f%m\uFF5C%F{3}%B\uF2C0 %b%f%n\n${${${vcs_info_msg_0_:A}%/.}:-%/}\n%F{2}%B%(#.#.$)%b%f '
PS2='  '

if autoload -RUz vcs_info; then
	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' disable-patterns '/*/.git(|/*)'
	zstyle ':vcs_info:git:*' formats $'%R/../%%U%r on %F{3}\uE0A0%f%b%%u/%S'
	show_git_info() { vcs_info 2>/dev/null }
	chpwd_functions+=(show_git_info)
fi

zle-line-init() {
	while :; do
		zle .recursive-edit
		local -i ret=$?
		[[ $ret == 0 && $KEYS == $'\4' ]] || break
		[[ -o ignore_eof ]] || exit 0
	done

	local saved_PS1=$PS1
	PS1='%B%(#.#.$)%b '

	zle .reset-prompt
	PS1=$saved_PS1

	if (( ret )); then
		zle .send-break
	else
		zle .accept-line
	fi
	return ret
}
zle -N zle-line-init

accept-line() {
	case "$BUFFER" in
		*\\)
			BUFFER+=$'\n'"$PS2"
			CURSOR=$#BUFFER
			;;
		*) zle .accept-line ;;
	esac
}
zle -N accept-line

# Completion
# ==========
_comp_options+=(globdots)
bindkey -M viins '^[[Z' reverse-menu-complete

# Enable case-insensitive and partial-word completion
zstyle ':completion:*' matcher-list\
	'm:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=*'

# Basic Vim Motions
# =================
zmodload "zsh/complist"
KEYTIMEOUT=1
bindkey -M vicmd 'l' vi-forward-char
bindkey -M vicmd 'h' vi-backward-char
bindkey -M vicmd 'k' vi-up-line-or-history
bindkey -M vicmd 'j' vi-down-line-or-history
bindkey -M vicmd "?" history-incremental-search-backward

# Edit buffer inside $EDITOR
# ==========================
if autoload -RUz edit-command-line; then
	zle -N edit-command-line
	bindkey -M vicmd '^e' edit-command-line
	bindkey -M viins '^e' edit-command-line
fi

# Change cursor's shape per keymap
# ================================
bindkey -N vireplace viins
vi-replace() {
	zle .vi-replace
	zle -K vireplace
}
vi-replace-chars() {
	zle -K vireplace
	zle .vi-replace-chars
	zle -K vicmd
}
zle-keymap-select() {
	case $KEYMAP in
		vicmd) echo -ne '\e[2 q' ;;
		vireplace) echo -ne '\e[3 q' ;;
		viins | *) echo -ne '\e[6 q' ;;
	esac
}
zle -N vi-replace
zle -N vi-replace-chars
zle -N zle-keymap-select
precmd_functions+=(zle-keymap-select)

# Navigate file-system
# ====================
zle-change-dir-up() {
	local old="$BUFFER"
	cd -q ../
	zle .kill-buffer
	zle .accept-line
	print -z $old
	print -nP "\n$(chpwd)"
}
zle -N zle-change-dir-up
bindkey -M vicmd 'J' zle-change-dir-up

# Signal Handlers
# ===============
TRAPERR() {
	print >&2 -P $'%F{red}\u2715 \n%f'
}

autoload -RUz compinit && $_
autoload -RUz autopair-init && $_
