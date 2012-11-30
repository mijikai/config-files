# Set up the prompt

autoload -Uz colors && colors
PROMPT='%{$fg[green]%}[%l] $fg[cyan]%n@%m %#: $fg[blue]%~${reset_color}
\$ '

setopt histignorealldups histsavenodups histignorespace histreduceblanks appendhistory
setopt promptsubst

# Use vi keybindings
bindkey -v

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history

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

if existexec aptitude; then
    alias upgrade='sudo aptitude safe-upgrade'
elif existexec apt-get; then
    alias upgrade='sudo apt-get upgrade'
elif existexec yaourt; then
    upgrade() {
        sudo sh -c 'etckeeper vcs add . && etckeeper vcs commit -m "Save uncommited changes"'
        yaourt -Syua && yaourt -C && sudo sh -c 'etckeeper vcs add . && etckeeper commit'
    }
elif existexec pacman; then
    upgrade() {
        sudo sh -c 'etckeeper vcs add . && etckeeper vcs commit -m "Save uncommited changes"'
        sudo pacman -Syu
        sudo zsh -c '
        for config in $(find /etc -type f -name "*.pacnew"); do
            vimdiff "${config%\.*}" "$config"
            while true; do
                read -p " Delete \""$config"\"? (Y/n): " Yn
                case $Yn in
                  [Yy]* ) sudo rm "$config" && \
                          echo " Deleted \""$config"\"."
                          break                         ;;
                  [Nn]* ) break                         ;;
                  *     ) echo " Answer (Y)es or (n)o." ;;
                esac
            done
        done'
    }
fi

fortune -c | fmt -80 -s | cowsay -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n
