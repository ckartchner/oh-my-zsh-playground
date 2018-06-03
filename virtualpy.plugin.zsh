# General python virtual environment support
# Supports both virtualenv and conda 

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
