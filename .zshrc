# set PATH so it includes user's private bin if it exists
if [ -d "/usr/local/bin" ] ; then
    export PATH="/usr/local/bin:$PATH"
fi
if [ -d "/usr/local/sbin" ] ; then
    export PATH="/usr/local/sbin:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/local/bin" ] ; then
    PATH="$HOME/local/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/local/lib" ] ; then
    LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
fi
if [ -d "$HOME/npm/bin" ] ; then
    PATH="$HOME/npm/bin:$PATH"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"  #"robbyrussell"

# export TERM=xterm-256color
export SHELL=zsh


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
encode64 git git-flow github gem npm osx cake svn command-not-found autojump 
coffee pip pep8 python ruby rvm tmux supervisor debian 
zsh-syntax-highlighting zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh


# Customize to your needs...

# has bugs with teamocil
export DISABLE_AUTO_TITLE="true"

setopt share_history
autoload -U zmv

# bash completion
autoload bashcompinit
bashcompinit

compctl -g '~/.teamocil/*(:t:r)' teamocil

bash_completion_list=("/etc/bash_completion.d/igor"
    # "/etc/bash_completion.d/ack-grep"
)
for f in $bash_completion_list; do
    [[ -s $f ]] && source $f;
done

# export EDITOR='emacsclient -t -a="" +%d %s'

# Example aliases
alias pc="proxychains4"
alias zshconfig="vi ~/.zshrc"
alias zshreload="source ~/.zshrc"
# alias ohmyzsh="ec ~/.oh-my-zsh"

alias view="vim -R "
alias to="teamocil --here"

alias fuck='eval $(thefuck $(fc -ln -1))'

alias gitroot='cd $(git rev-parse --show-cdup)'

alias ls="ls --color=auto"
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'
alias lst='ls -tr'
alias lsd='ls -d */'		# list dir
alias lsdt='ls -dt */ '		# list dir
alias dud='du -hs * | sort -h'

alias sah='ssh-add ~/.ssh/id_rsa_home'
alias saw='ssh-add ~/.ssh/id_rsa_work'

alias ec='emacsclient -t -a=""'
alias se='SUDO_EDITOR="emacsclient -t" sudo -e'

# syntax highlight cat
alias ccat='pygmentize -g -O bg=dark'
alias pylint='pylint --output-format=colorized'

# svn
function svn_repo {
    repo=`svn info | sed -n "s/URL: //p" | sed -n "s/\/$(svn_get_branch_name)//p"`
    return $repo
}
alias ss='svn status'
alias sdgbk='luit -encoding gbk svn diff'
alias sd='svn diff'
alias scm='svn commit -m '
alias sls='svn log --stop-on-copy'
alias sl='svn log --limit 5'
alias svn_br='svn ls -v $(svn_repo)/branches'

# git
alias gr='gitroot'
alias grb='git fetch && git rebase origin/master'
alias gs='git status'
alias gp='git push'
alias gpl='git pull --rebase'
alias gf='git flow'
alias gpt='git push && git push --tags'
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias gcam='git commit -am '
alias gcm='git commit -m '
alias gdlast='git diff HEAD^ HEAD'
alias grep='grep --line-buffered --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias grep='grep --line-buffered --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias ra='ranger'
alias i='info'

alias rp='rake publish'
alias rgp='rake generate && rake preview'

alias ipy='ipython'
alias ipyl='ipython --pylab=auto'
alias ack='ACK_PAGER_COLOR="less -x4SRFX" ack '

alias ag='\ag --pager "less -R"'

alias sc='screen'
alias scb='screen -dr normaltask || screen -S normaltask'

# tmux
custom_tmux() {
    tmux -2 attach -t $1 || tmux -2 new -s $1
}

alias tmux='tmux -2'
alias tmb='tmux -2 attach -t normaltask || tmux -2 new -s normaltask'
alias tmn=custom_tmux

# Easily search running processes (alias).
alias 'psg'='ps auxf | grep '
alias 'psl'='ps awwfux | less -S'

alias workon='source activate'

# safe rm
#alias rm="trash-put"

# kill processes that match pattern
psgkill()
{
    processes=`ps aux | grep $1 | grep -v grep`
    if [ -n "$processes" ]; then
	pids=`echo $processes | awk '{print $2}'`
	echo "Killing processes matched \"$1\":"
	echo "$processes"
	echo -n "Are you sure to kill all of them. [Y/n]: "
	read y_or_n
	if [ "$y_or_n" = "y" -o "$y_or_n" = "Y" -o -z "$y_or_n" ]; then
	    echo $pids | xargs kill
	fi
    else
	echo "Not found any processes match pattern \"$1\""
    fi
}

# disable auto correct
unsetopt correct_all

# # autojump
# [[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# man
vman () {
    export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
                     vim -R \
                     -c 'set ft=man nomod nolist' \
                     -c 'map q :q!<CR>' \
                     -c 'map d <C-D>' \
                     -c 'map u <C-U>' \
                     -c 'map j <C-E>' \
                     -c 'map k <C-Y>' \
                     -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

    # invoke man page
    man $*

    # we muse unset the PAGER, so regular man pager is used afterwards
    unset PAGER
}

alias man=vman                  # use \man to invoke original man

# cd path
# CDPATH=:..:~:~/projects

# # ========================= theme =========================
# # prompt, forked from robbyrussell
#
# function virtualenv_info {
#     [ $VIRTUAL_ENV ] # && echo '('`basename $VIRTUAL_ENV`') '
# }
#
# PROMPT='%{$fg_bold[red]%}@ %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(svn_prompt_info)$(virtualenv_info)$(git_prompt_info)$(git_prompt_ahead)%{$fg_bold[blue]%} %# %{$reset_color%}'
#
# # Prompt format
# RPROMPT='$FG[244] %n@%m%{$reset_color%}'
#
# # SVN
# SVN_SHOW_BRANCH="true"
#
# ZSH_THEME_SVN_PROMPT_AHEAD="%{$fg[yellow]%} * %{$reset_color%}"
# ZSH_THEME_SVN_PROMPT_PREFIX="svn:(%{$fg[red]%}"
# ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}x%{$reset_color%}"
# ZSH_THEME_SVN_PROMPT_CLEAN="%{$fg[blue]%})"
#
#
# # Format for git_prompt_ahead()
# ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%} * %{$reset_color%}"
#
# ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}x%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
# # ------------------------- theme -------------------------

# entertainment
alias matrix='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'


if [ -d "/usr/local/opt/coreutils/libexec/gnubin" ] ; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi
if [ -d "/usr/local/opt/coreutils/libexec/gnuman" ] ; then
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi
# export LC_CTYPE="zh_CN.UTF-8"

export PATH=${JAVA_HOME}/bin:$PATH

# do some os specific config
if [ "$(uname)" = "Darwin" ]; then
    alias 'psg'='ps aux | grep '
    # Do something under Mac OS X platform
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    # Do something under Linux platform
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under Windows NT platform
fi

export SVN_EDITOR=vim
export EDITOR=vim

random-string()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

# mount the android file image
#function mountAndroid { hdiutil attach ~/android.dmg -mountpoint /Volumes/android; }

# export SLIMERJSLAUNCHER=/Applications/Firefox.app/Contents/MacOS/firefox

export GOPATH="$HOME/.go"


# if [ -d "$HOME/.pyenv/shims" ] ; then
#     PATH="$HOME/.pyenv/shims:$PATH"
# fi
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/anaconda3/bin:$PATH"
export PATH="$HOME/miniconda3/bin:$PATH"
