if status is-interactive
    # Commands to run in interactive sessions can go here
end

export XDG__RUNTIME_DIR=/run/user/1000
mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR

fish_add_path /home/linus/.dotnet/tools

set RANGER_LOAD_DEFAULT_RC false
