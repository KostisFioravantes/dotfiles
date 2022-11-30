${HOME:?"home variable is missing"}
export	XDG_CACHE_HOME="$HOME/.cache"\
	XDG_CONFIG_HOME="$HOME/.config"\
	XDG_DATA_HOME="$HOME/.local/share"\
	XDG_STATE_HOME="$HOME/.local/state"

export	LESSHISTFILE=-\
	ZDOTDIR="$XDG_CONFIG_HOME/zsh" 

PATH="$PATH:${XDG_DATA_HOME%/*}/bin"
