if status is-interactive
    # Commands to run in interactive sessions can go here
end

export XDG__RUNTIME_DIR=/run/user/1000
mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR

fish_add_path /home/linus/.dotnet/tools

set RANGER_LOAD_DEFAULT_RC false

set -g fish_greeting ""

alias fucking "sudo"
alias ff "fastfetch"
alias ls "lsd"
alias si "kitty +kitten icat"
#alias weather "curl v2.wttr.in/jönköping"
alias weather "curl wttr.in/Jönköping"
alias yoink "git pull"

function yeet
    git add .
    git commit -m $argv
    git push
end
