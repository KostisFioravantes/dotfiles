export	VISUAL="/bin/vi"\
	EDITOR="/bin/vi"\
	ZDOTDIR="$XDG_CONFIG_HOME/zsh"\
	XDG_CACHE_HOME="$HOME/.cache"\
	XDG_CONFIG_HOME="$HOME/.config"\
	XDG_DATA_HOME="$HOME/.local/share"\
	XDG_STATE_HOME="$HOME/.local/state"

export	LESSHISTFILE=-

PATH="$PATH:${XDG_DATA_HOME%/*}/bin:"

mkdir 2>&1 >/dev/null -p\
	$XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME\
	$XDG_STATE_HOME $ZDOTDIR ${PATH##*:}
