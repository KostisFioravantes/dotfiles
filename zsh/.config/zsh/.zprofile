export	TERM="st"\
	VISUAL="/bin/vi"\
	EDITOR="/bin/vi"\
	BROWSER="/bin/firefox"

export	GOPATH="$XDG_CONFIG_HOME/go"\
	GNUPGHOME="$XDG_CONFIG_HOME/gnupg"\
	MANPATH="$MANPATH:$XDG_DATA_HOME/man"\
	TERMINFO_DIRS="$TERMINFO_DIRS:$XDG_DATA_HOME/terminfo"

mkdir 2>&1 >/dev/null -p\
	$GOPATH $GNUPGHOME ${MANPATH##*:}\
	${TERMINFO_DIRS##*:}

[ ! -z $DISPLAY ] && return
[ $XDG_VTNR -ne 1 ] && return

export	XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"\
	XAUTHORITY="$XDG_CONFIG_HOME/X11/.Xauthority"\
	ERRFILE="$XDG_CONFIG_HOME/X11/.xsession-errors"

mkdir 2>&1 >/dev/null -p -m 700	${XINITRC%/*}
test -f $XAUTHORITY || install -m 600 /dev/null $_
test -f $ERRFILE || install -m 600 /dev/null $_

exec startx $XINITRC
