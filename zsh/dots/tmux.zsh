! [ $commands[tmux] ] && return

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

_tmux_pane_words() {
  tmux capture-pane -p |
    tr -d '\n' |                                # remove all the line breaks
    perl -pe 's/[^[:alnum:]\/~.-]|^[\/]/ /g' |  # remove special chars
    perl -pe 's/\s+/\n/g' |                     # split words onto newlines
    sort -u |                                   # sort
    grep -v "^$"                                # remove blank line
}

fzf-tmux-widget() {
  local selected
  if selected=$(_tmux_pane_words | fzf --height="40%" --reverse); then
    LBUFFER="$LBUFFER$selected"
  fi
  zle redisplay
}

zle     -N    fzf-tmux-widget
bindkey '^Y'  fzf-tmux-widget
