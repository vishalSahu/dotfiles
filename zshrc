
autoload -Uz compinit
compinit

# auto suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# User configuration

# bind keys
#bindkey '[D' backward-word
#bindkey '[C' forward-word

bindkey \^U backward-kill-line

# don't share history; https://github.com/robbyrussell/oh-my-zsh/issues/2537
unsetopt share_history

# prepend a cmd with space to avoid adding it to history (https://stackoverflow.com/a/13661794)
setopt histignorespace

source ~/.profile

# Fuzzy auto-complete and bindings
# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use fd with fzf
# https://github.com/sharkdp/fd
# follow symbolic links and include hidden files (but exclude .git folders)
export FZF_DEFAULT_COMMAND='fd --type file --color=auto --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# commands to be executed during startup

# export MANPATH="/usr/local/man:$MANPATH"
