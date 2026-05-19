# PATH — set directly to avoid relying on fish_user_paths universal variable
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH     # macOS Apple Silicon
set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH            # Linux Homebrew
set -gx PATH /usr/local/bin $PATH                            # macOS Intel / system
set -gx PATH $HOME/.local/bin $HOME/bin $PATH

# Homebrew env (sets HOMEBREW_PREFIX, MANPATH, INFOPATH, etc.)
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# Editor
if set -q SSH_CONNECTION
    set -gx EDITOR vim
else
    set -gx EDITOR nvim
end

# zoxide (replaces cd)
if command -q zoxide
    zoxide init fish | source
    alias cd="z"
end
alias cdd="builtin cd"

# fzf
set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# sesh
alias sl="sesh connect (sesh list | fzf)"

function sesh-sessions
    set session (sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    if test -n "$session"
        sesh connect $session
    end
end

function fish_user_key_bindings
    bind \es sesh-sessions
end

set -g fish_key_bindings fish_default_key_bindings
