# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

force_color_prompt=yes

# Source git command auto completion 
source /etc/bash_completion.d/git

# Get current branch if inside a git repo
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

# Customize prompt
export PS1="[\u \w]\[\e[36m\]\`git_branch\`\[\e[m\]\\$ "


