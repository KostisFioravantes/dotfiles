export XDG_CACHE_HOME="$HOME/.cache"\
	XDG_CONFIG_HOME="$HOME/.config"\
	XDG_DATA_HOME="$HOME/.local/share"\
	XDG_STATE_HOME="$HOME/.local/state"

export LANG="en_US.UTF-8"\
	HISTFILE="/dev/null"\
	LESSHISTFILE="/dev/null"\

ZDOTDIR="$XDG_CONFIG_HOME/zsh"
PATH+=":/usr/local/go/bin"
PATH+=":$HOME/.local/bin"

. "$HOME/.cargo/env"
