# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Append commands to the bash command history file (~/.bash_history)
# instead of overwriting it.
shopt -s histappend

# some aliases
# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
   #eval `dircolors -b`
   alias ls='ls -F' # color ls for OSX
   alias dir='ls --color=auto --format=vertical'
   alias vdir='ls --color=auto --format=long'
fi

alias less='less -iR'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias zgrep='zgrep --color=auto'
alias l='ls -lLBhX --time-style=locale'
alias la='ls -la $1 | less'
alias ll='ls -lX'
alias lx='ls -lXB' # sort by ext
alias lk='ls -lSr' # soft by size
alias h='history'
alias j='jobs -l'
# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias du='du -kh'  # Makes a more readable output.
alias df='df -kTh'
alias ..='cd ..'
alias ...='cd ../..'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# ANSI color code
#echo -e "\033[1mBold\033[0m -- \033[01;04mBold and Underline\033[0m -- \033[4mUnderline\033[0m"
#Foreground colors: 30=black;31=red;32=green;33=red;34=blue;35=magenta;36=cyan;37=white;38=?;39=white(default);
#Background colors: 40=black;41=red;42=green;43=red;44=blue;45=magenta;46=cyan;47=white;48=?;49=black(default);

PS1='\[\e[0;33m\]\h: \w\[\e[m\] \[\e[0;32m\]\$ \[\e[m\]'
export PROMPT_DIRTRIM=3 #trims the directory in \w to 4

# Use auto completion provided by brew
if [ -f $(brew --prefix)/etc/bash_completion  ]; then
   . $(brew --prefix)/etc/bash_completion
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
   xterm*|rxvt*)
      HOST=`echo ${HOSTNAME} | cut -d"." -f1`;
      show_command_in_title_bar()
      {
         case "$BASH_COMMAND" in
            *\033]0*)
               # The command is trying to set the title bar as well;
               # this is most likely the execution of $PROMPT_COMMAND.
               # In any case nested escapes confuse the terminal, so don't
               # output them.
               ;;
            *)
               echo -ne "\033]0;${BASH_COMMAND}\007"
               ;;
         esac
      }
      trap show_command_in_title_bar DEBUG
      ;;

   *)
      ;;
esac

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

