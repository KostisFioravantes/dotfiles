zmodload "zsh/complist"

KEYTIMEOUT=1
bindkey -v
bindkey -M vicmd 'l' vi-forward-char
bindkey -M vicmd 'h' vi-backward-char
bindkey -M vicmd 'k' vi-up-line-or-history
bindkey -M vicmd 'j' vi-down-line-or-history
bindkey -M vicmd "?" history-incremental-search-backward

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M viins '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

# Navigate file-system using basic vimium shortcuts.
skip-and-hold()
{
	local tmp="$BUFFER"
	zle .kill-buffer
	zle .accept-line
	print -z "$tmp"
}

zle-change-dir-up()
{
	builtin cd ..
	skip-and-hold
}
zle -N zle-change-dir-up
bindkey -M vicmd 'J' zle-change-dir-up

# Change cursor shape according to keymap.
bindkey -N vireplace main
vi-replace()
{
	zle .vi-replace
	zle -K vireplace
}

vi-replace-chars()
{
	local prev="$KEYMAP"
	zle -K vireplace
	zle .vi-replace-chars
	zle -K $prev
}

zle-keymap-select()
{
	case $KEYMAP in
		vicmd) echo -ne '\e[2 q' ;;
		vireplace) echo -ne '\e[3 q' ;;
		viins | main) echo -ne '\e[6 q' ;;
	esac
}

zle -N vi-replace 
zle -N vi-replace-chars
zle -N zle-keymap-select
zle -A zle-keymap-select zle-line-init 

# Emulate change/delete/yank a/in pareneheses/brackets...etc.
for i in {c,d,v,y}{a,i}{"()b","[]","{}B","<>"}
do
	for j in {4..${#i}}
	do bindkey -M vicmd -s "${i:0:2}$i[$j]" "${i:0:3}"
	done
done

for i in {y}{a,i}{"()b","[]","{}B","<>"}
do
	local mv='f'
	[ $i[2] == 'i' ] && mv='t'
	local res="$mv$i[4]v${(U)mv}$i[3]$i[1]"
	bindkey -M vicmd -s "${i:0:3}" "$res"
done

for i in {c,d}{a,i}{"()b","[]","{}B","<>"}
do
	local mv='f'
	[ $i[2] == 'i' ] && mv='t'
	local res="$mv$i[4]v${(U)mv}$i[3]$i[1]"
	bindkey -M vicmd -s "${i:0:3}" "$res\eu$res"
done


#,\',\",\`}
#
#	local res="$mv$i[3]v${(U)mv}$i[3]$i[1]"
#
#	if [[ "${#i}" -eq 3 ]]; then
#		bindkey -M vicmd -s "$i" "$res"
#		continue
#	fi
#
 
