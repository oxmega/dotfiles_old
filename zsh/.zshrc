#!/usr/bin/zsh
#·▄▄▄▄•    .▄▄ ·      ▄ .▄         ▄▄▄   ▄▄·
#▪▀·.█▌    ▐█ ▀.     ██▪▐█         ▀▄ █·▐█ ▌▪
#▄█▀▀▀•    ▄▀▀▀█▄    ██▀▐█         ▐▀▀▄ ██ ▄▄
#█▌▪▄█▀    ▐█▄▪▐█    ██▌▐▀         ▐█•█▌▐███▌
#·▀▀▀ •     ▀▀▀▀     ▀▀▀ · ▀  ▀  ▀ .▀  ▀·▀▀▀
# 1OX!//acannibalox//raisedfist.net//ox@raisedfist.net

PATH="$HOME/.local/bin:$PATH"
set -o vi
[ -f "$XDG_CONFIG_HOME/user-dirs.dirs" ] && source "$XDG_CONFIG_HOME/user-dirs.dirs"
[ -f "$HOME/.config/ls_colors" ] && eval $( dircolors -b $HOME/.config/ls_colors )
#autoload -U colors && colors
### source all of our zsh files
[ -d "$HOME"/.zsh ] && for f in "$HOME"/.zsh/*.zsh; do source "$f"; done

### mpd running in the background. hardly noticeable
[ ! -s ~/.config/mpd/mpd.pid  ] && mpd &>/dev/null

# Start the gpg-agent if not already running
#if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
#  gpg-connect-agent /bye >/dev/null 2>&1
#fi

##
# Completion
##
autoload -Uz compinit
compinit
#autoload -U ~/.zsh/completion/*(:t)
zstyle ':completion:*' rehash true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
### prompt (basic)
newline='\n'
case $(hostname -s) in
    czarface) PS1="%(?.%F{cyan}.%F{red})✗ %f%F{187}%f%n.%m%F %f%~» " ;;
    *) PS1="%n.%m %~ %(?.%F{magenta}.%F{red})"$'\n'"» %f" ;;
esac

# TMUX stuff that seems buggy?
#case "$TERM" in
#    tmux*)
#        PROMPT_COMMAND="printf '\033k$(hostname)\033\\';"${PROMPT_COMMAND}
#        ;;
#esac
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}
#
export DISABLE_AUTO_TITLE=true

precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
   VIM_PROMPT="%{$fg_bold[blue]%} [% *]%  %{$reset_color%}"
   RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
