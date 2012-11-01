# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ "$TERM" == "linux" ]; then
    # Use solarized colors
    S_base03='002b36'
    S_base02='073642'
    S_base01='586e75'
    S_base00='657b83'
    S_base0='839496'
    S_base1='93a1a1'
    S_base2='eee8d5'
    S_base3='fdf6e3'
    S_yellow='b58900'
    S_orange='cb4b16'
    S_red='dc322f'
    S_magenta='d33682'
    S_violet='6c71c4'
    S_blue='268bd2'
    S_cyan='2aa198'
    S_green='859900'

    # black dark/light
    echo -en "\e]P0$S_base02"
    echo -en "\e]P8$S_base03"

    # red dark/light
    echo -en "\e]P1$S_red"
    echo -en "\e]P9$S_orange"

    # green dark/light
    echo -en "\e]P2$S_green"
    echo -en "\e]PA$S_base01"

    # yellow dark/light
    echo -en "\e]P3$S_yellow"
    echo -en "\e]PB$S_base00"

    # blue dark/light
    echo -en "\e]P4$S_blue"
    echo -en "\e]PC$S_base0"

    # magenta dark/light
    echo -en "\e]P5$S_magenta"
    echo -en "\e]PD$S_violet"

    # cyan dark/light
    echo -en "\e]P6$S_cyan"
    echo -en "\e]PE$S_base1"

    # white dark/light
    echo -en "\e]P7$S_base2"
    echo -en "\e]PF$S_base3"
    clear # for backgroud artifact
fi


# remove all the duplicate lines from history preserving latest
# commands
remove_dup="$(cat <<python
from collections import OrderedDict
from os.path import expanduser

hist_path = expanduser('~/.bash_history')
with open(hist_path) as hist:
    lines = hist.readlines()

no_dup = OrderedDict()
while lines:
    no_dup[lines.pop()] = ''
with open(hist_path, 'w') as hist:
    hist.writelines(reversed(no_dup))
python
)"
python3 -c "$remove_dup"
unset remove_dup

set -o vi

fortune -c
