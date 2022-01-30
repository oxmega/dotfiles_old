PATH="`/usr/bin/ruby -e 'puts Gem.user_dir'`/bin:/bin:$HOME/bin:$HOME/bin/toolkit:$PATH:$HOME/dmenu:$HOME/bspc.brains"

#jGPGKEY=3845A81C

setopt auto_cd

# HISTORY
HISTFILE="$HOME/.zsh_history"
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
HISTSIZE=1500
SAVEHIST=1000

# EDITOR
export EDITOR='vim'
export USE_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# vi mode - there are binds in here that should be in alias but wanna
#r fight about it?
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey -s jj $'\e'

export KEYTIMEOUT=3

# for linux console and RH/Debian xterm
bindkey "\e[1~": beginning-of-line
bindkey "\e[4~": end-of-line
bindkey "\e[5~": beginning-of-history
bindkey "\e[6~": end-of-history
bindkey "\e[7~": beginning-of-line
bindkey "\e[3~": delete-char
bindkey "\e[2~": quoted-insert
bindkey "\e[5c": forward-word
bindkey "\e[5d": backward-word
bindkey "\e\e[c": forward-word
bindkey "\e\e[d": backward-word
bindkey "\e[1;5c": forward-word
bindkey "\e[1;5d": backward-word

# for rxvt
bindkey "\e[8~": end-of-line
bindkey "\eOF": end-of-line

# for freebsd console
bindkey "\e[H": beginning-of-line
bindkey "\e[F": end-of-line

# COLORED MAN (awkward) pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[01;34;23;92m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

#export LESS_TERMCAP_mb=$'\e[01;34m'
#export LESS_TERMCAP_md=$'\e[01;34m'
#export LESS_TERMCAP_me=$'\e[0m'
#export LESS_TERMCAP_se=$'\e[0m'
#export LESS_TERMCAP_so=$'\e[01;44;33m'
#export LESS_TERMCAP_ue=$'\e[0m'
#export LESS_TERMCAP_us=$'\e[38;05;111m;'

# Yaourt
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
