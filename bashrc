if [ "`uname`" == "Darwin" ]; then
  # Mac OS
  alias ls='ls -GF'
  #alias vim='/usr/local/Cellar/vim/7.4.1864_1/bin/vim'
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
  # Complement
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  source /usr/local/etc/bash_completion.d/git-completion.bash

  export PATH=/Users/sbhr/.nodebrew/current/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin
else
  # Others
  alias ls='ls -GF --color=auto'
  . /usr/local/share/bash-completion/bash_completion
  source /usr/local/share/bash-completion/git-prompt.sh
  source /usr/local/share/bash-completion/git-completion.bash
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi
  # nvm
  export NVM_DIR="/home/shibahara/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
complete -cf sudo

# Alias
alias l='ls -d .*'
alias ll='ls -lh'
#alias ls='ls -GF'
alias la='ls -lA'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'
alias vi='vim'
# alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias less='less -MN'
alias svim='sudo -E vim'

#export LSCOLORS=gxfxcxdxbxegedabagacad

function ssh() {
  if [[ -n $(printenv TMUX) ]]; then
    local window_name=$(tmux display -p '#{window_name}')
    # tmux rename-window -- "$@[-1]" # zsh specified
    tmux rename-window -- "${!#}" # for bash
    command ssh $@
    tmux rename-window $window_name
  else
    command ssh $@
  fi
}

## ssh-agent
#if [ "`uname`" == "Linux" ]; then
#  agent="$HOME/.ssh/agent"
#  if [ -S "$SSH_AUTH_SOCK" ]; then
#      case $SSH_AUTH_SOCK in
#      /tmp/*/agent.[0-9]*)
#          ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
#      esac
#  elif [ -S $agent ]; then
#      export SSH_AUTH_SOCK=$agent
#  else
#      echo "no ssh-agent"
#  fi
#fi

# Setup ssh-agent
if [ -f ~/.ssh-agent ]; then
  . ~/.ssh-agent
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID; then
  ssh-agent > ~/.ssh-agent
  . ~/.ssh-agent
fi
ssh-add -l >& /dev/null || ssh-add

function share_history {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=9999

# prompt
GIT_PS1_SHOWDIRTYSTATE=true
export PS1="\[\e[36m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\]:\[\e[34m\]\w \[\e[0m\](\d \t)\n$ "
# export PS1="\[\e[36m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\]:\[\e[34m\]\w \[\e[33m\]$(__git_ps1 [%s]) \[\e[0m\](\d \t)\n$ "

