#!/usr/bin/env bash
selected=`cat ~/tmux/.tmux-cht-languages ~/tmux/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/tmux/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "curl -s cht.sh/$selected/$query | less -R"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less -R"
fi
