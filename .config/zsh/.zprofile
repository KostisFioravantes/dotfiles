: ${HOME:?"missing environment variable"}
: ${XDG_STATE_HOME:="$HOME/.local/state"}
: ${XDG_DATA_HOME:="$HOME/.local/share"}
: ${XDG_CONFIG_HOME:="$HOME/.config"}
: ${XDG_CACHE_HOME:="$HOME/.cache"}

export EDITOR="vi" VISUAL="vi"

[ $XDG_VTNR -gt 2 ] && return

export TERM="kitty"\
	TERMINAL="kitty"\
	BROWSER="/bin/firefox"

# X11
# ===
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"\
	XAUTHORITY="$XDG_CONFIG_HOME/X11/.Xauthority"\
	ERRFILE="$XDG_CONFIG_HOME/X11/.xsession-errors"

mkdir 2>&1 >/dev/null -p -m 700 ${XINITRC%/*}
test -f $XAUTHORITY || install -m 600 /dev/null $_
test -f $ERRFILE || install -m 600 /dev/null $_

export DISPLAY=${DISPLAY:-":0"}
exec startx $XINITRC
