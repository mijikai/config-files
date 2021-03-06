# Set up the prompt

autoload -Uz colors && colors
PROMPT='%{$fg[green]%}[%l] $fg[cyan]%n@%m %#: $fg[blue]%~${reset_color}
\$ '

setopt histignorealldups histsavenodups histignorespace histreduceblanks appendhistory
setopt promptsubst

# Use vi keybindings
bindkey -v

autoload zkbd
[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]] && zkbd
source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
# setup key accordingly
[[ -n "${key[Home]}"    ]]  &&  bindkey "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  &&  bindkey "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  &&  bindkey "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  &&  bindkey "${key[Delete]}"  delete-char &&
                                bindkey -M vicmd "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  &&  bindkey "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  &&  bindkey "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  &&  bindkey "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  &&  bindkey "${key[Right]}"   forward-char

# Keep many lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=30000
SAVEHIST=30000
HISTFILE=~/.zsh_history

# Use vim as EDITOR
export EDITOR=vim

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
bindkey -r '^[/'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# System maintenance alias
existexec() {
    local execpath=$(which "$1" 2> /dev/null) && [ -x "$execpath" ]
    return $?
}

if existexec aria2c; then
    alias aria2c='aria2c -d ~/Downloads'
fi

fortune -c | fmt -80 -s | cowsay -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n
