#!/bin/sh
alias\
	chgrp='\chgrp --preserve-root'\
	chmod='\chmod --preserve-root'\
	chown='\chown --preserve-root'\
	dotfile='\git --git-dir="$HOME/dotfiles.git/" --work-tree="$HOME"'\
	ga='\git add'\
	gb='\git branch'\
	gs='\git status'\
	gaa='ga --all'\
	grep='\grep --colour=auto --perl-regexp'\
	rgrep='grep --dereference-recursive'\
	rm='\rm -I'\
