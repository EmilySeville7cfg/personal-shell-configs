#!/usr/bin/env fish

not status is-interactive && exit
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

set --global MINE_PATH $HOME/Documents/mine
set --global WORK_PATH $HOME/Documents/work

set --global TRUE 0
set --global FALSE 1

set --global --export LESS_TERMCAP_md (set_color --bold cyan)
set --global --export LESS_TERMCAP_us (set_color --bold --underline blue)

set --global --export LESS_TERMCAP_me (set_color normal)
set --global --export LESS_TERMCAP_ue (set_color normal)

set --global --export GEM_HOME $HOME/gems
set --prepend PATH $HOME/gems/bin

set --export WINEDEBUG fixme-all
