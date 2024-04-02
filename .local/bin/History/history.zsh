#!/bin/zsh
# if Param1 file is modified later than
# USER's history then init it with Param1.
init_history() {
	[[ $# -gt 0 && -f $1 ]]	|| return 0

	local MODTIME="#$(/bin/date -Iseconds -r $1)"
	exec 3<>$HISTFILE
	unset REPLY
	read -u 3
	exec 3<&-

	if [ "$REPLY" != "$MODTIME" ]; then
		echo "$MODTIME" > $HISTFILE
		/bin/cat $1 >> $HISTFILE
	fi
}

() {
	local	UMASK=$(umask)\
		CACHE_DIR="$XDG_CACHE_HOME/zsh"

	if [ -z "$XDG_CACHE_HOME" ]; then
		umask 000
		/bin/mkdir -p ${TMPPREFIX:-"/tmp/zsh"}
		CACHE_DIR="${TMPPREFIX:-/tmp/zsh}/$USER"
	fi

	umask 077
	/bin/mkdir -p $CACHE_DIR
	HISTFILE="$CACHE_DIR/.history"
	HISTSIZE=100000
	SAVEHIST=100000

	init_history "$1/default_histories/$USER"
	umask $UMASK
} $(/bin/dirname $0)

unfunction init_history
