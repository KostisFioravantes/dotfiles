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

# Xorg
# ====
export DISPLAY=${DISPLAY:-":0"}\
	XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"\
	XAUTHORITY="$XDG_CONFIG_HOME/X11/.Xauthority"

mkdir 2>&1 >/dev/null -p -m 700 ${XINITRC%/*}
exec startx $XINITRC
