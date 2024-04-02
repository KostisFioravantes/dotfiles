#!/bin/zsh
case $OSTYPE in
	linux-gnu* | msys* | cygwin* | solaris*)
		alias ls='/bin/ls --color=auto --file-type'\
			ll='ls -hlrt --time-style=+"%H:%M %d/%m/%g"'
		;;

	freebsd* | darwin*)
		alias ls='/bin/ls -FG'\
			ll='ls -hlrt -D "%H:%M %d/%m/%g"'
		;;

	*) alias ls='/bin/ls -F' ll='ls -hlrt' ;;
esac
alias la='ls -A'\
	lla='ll -A'\
	llr='ll -R'\
	lar='la -R'\
	llar='lla -R'
