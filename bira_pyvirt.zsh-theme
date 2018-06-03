# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# Disable virtualenv prompt changes
#https://virtualenv.pypa.io/en/stable/reference/#envvar-VIRTUAL_ENV_DISABLE_PROMPT
export VIRTUAL_ENV_DISABLE_PROMPT=1

#Disable conda prompt changes
#https://conda.io/docs/user-guide/configuration/use-condarc.html#change-command-prompt-changeps1
#changeps1: False
`conda config --set changeps1 false`

function py_virtual {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo '('%F{white}`basename $VIRTUAL_ENV`%f') '
    elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        echo '('%F{white}`basename $CONDA_DEFAULT_ENV`%f') '
    fi
}

local venv='$(py_virtual)'

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭─${venv}${user_host} ${current_dir} ${rvm_ruby}${git_branch}
╰─%B${user_symbol}%b "
RPS1="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
