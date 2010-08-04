source ~/.bashrc

# my CDPATH
export CDPATH=.:~:/usr/local/:~/Projects:~/Projects:~/DMC

# Make TextMate the default Subversion editor.  I have no idea how this works on machines without TextMate.
export SVN_EDITOR="mate -w"
export GIT_EDITOR="mate -w"

# my PATH
export PATH="$HOME/bin:$PATH"

# Lisa aliases
alias cdl='cd ~/DMC/lisa'
alias tl='terminit lisa'

# Dashboard aliases
alias cdd='cd ~/DMC/dashboard_prototype'
alias td='terminit dashboard'

# Rails Settings
export AUTOFEATURE=true
alias cpd='cap production deploy'
alias cpdm='cap production deploy:migrations'
alias csd='cap staging deploy'
alias csdm='cap staging deploy:migrations'

# Convenience aliases
alias realias='source ~/.bash_profile'
alias ll='ls -AlFT'
alias ls='/bin/ls -F'
alias flushdns='sudo dscacheutil -flushcache'

# Compress the cd, ls -l series of commands.
alias lc="cl"
cl() { cd "$@" && ll; }

# Process aliases
alias zom="ps aux | awk '{ print $8 \" \" $2 }' | grep -w Z"

# Subversion aliases
alias sup='svn info; svn update'
alias sci='svn ci $*'
alias sco='svn co $*'
alias sd='svn diff $*'
alias sst='svn status'
alias sl='svn log $*'

# git aliases
alias gs='git status'
alias gb='git branch -a --color'
alias gd='git diff --color'
alias gc='git commit -e'
alias ga='git add'
alias gl='git log'
alias gps='git push'
alias gpl='git pull'
alias gco='git checkout'

# Command aliases
alias lynx='/Applications/lynx.command'
alias software_update='sudo softwareupdate -i -a'

# Generate an ssh key pair
alias keypair='ssh-keygen -t dsa'

# BASH Shell configs
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=erasedups
shopt -s histappend

# Set the CLI prompt
if [ -n "$PS1" ]; then PS1='\h:\w \u\$ '; fi

# Attempt to correct mispellings of directories
shopt -s cdspell

# Allow files beginning with a dot to be returned in filename expansions
shopt -s dotglob

# Analyze my .bash_history
alias ba='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# Set the window xterm window title
case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
        ;;
    *)
        ;;
esac

# Set up better bash completion.
# Get bash_completion here: http://www.caliban.org/bash/index.shtml#completion
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

_mategem()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    local gems="$(gem environment gemdir)/gems"
    COMPREPLY=($(compgen -W '$(ls $gems)' -- $curw));
    return 0
}

# Also set up rake task completion
complete -C /Users/sean/Dropbox/Laptop/home/rakefiles/rake_completion.rb -o default rake

# Open up gem documentation in a browser.
# http://stephencelis.com/archive/2008/6/bashfully-yours-gem-shortcuts
gemdoc() {
  local gemdir=`gem env gemdir`
  open $gemdir/doc/`ls $gemdir/doc/ | grep $1 | sort | tail -1`/rdoc/index.html
}

_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(ls `gem env gemdir`/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _gemdocomplete gemdoc
complete -F _mategem -o dirnames mategem

source ~/.git-completion.sh
function parse_git_dirty {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]
	then
		echo "\e[0;31m"
	else
		echo "\e[0;00m"
  fi
} 

PS1='\u@\h:\w$(__git_ps1 " (\[$(parse_git_dirty)\]%s\[\e[m\])") \$ '
export PS1
