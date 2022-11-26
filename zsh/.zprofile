export	TERM="st"\
	VISUAL="/bin/vi"\
	EDITOR="/bin/vi"\
	BROWSER="/bin/firefox"\
	XDG_CACHE_HOME="$HOME/.cache"\
	XDG_CONFIG_HOME="$HOME/.config"\
	XDG_DATA_HOME="$HOME/.local/share"\
	XDG_STATE_HOME="$HOME/.local/state"

export	GOPATH="$XDG_CONFIG_HOME/go"\
	ZDOTDIR="$XDG_CONFIG_HOME/zsh"\
	GNUPGHOME="$XDG_CONFIG_HOME/gnupg"\
	MANPATH="$MANPATH:$XDG_DATA_HOME/man"\
	PASSWORD_STORE_DIR="$XDG_DATA_HOME/password_store"\
	TERMINFO_DIRS="$TERMINFO_DIRS:$XDG_DATA_HOME/terminfo"

export	LESSHISTFILE=-

PATH="$PATH:${XDG_DATA_HOME%/*}/bin:"

mkdir 2>&1 >/dev/null -p\
	$XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME\
	$XDG_STATE_HOME $GOPATH $ZDOTDIR $GNUPGHOME\
	$PASSWORD_STORE_DIR ${MANPATH##*:} ${PATH##*:}

[ ! -z $DISPLAY ] && return
[ $XDG_VTNR -ne 1 ] && return

export	XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"\
	XAUTHORITY="$XDG_CONFIG_HOME/X11/.Xauthority"\
	ERRFILE="$XDG_CONFIG_HOME/X11/.xsession-errors"

mkdir 2>&1 >/dev/null -p\
	${XINITRC%/*} ${ERRFILE%/*}

for file in $XINITRC $ERRFILE
do [ ! -f $file ] && :> $file
done

exec startx $XINITRC
