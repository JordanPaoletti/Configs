# shellcheck shell=bash
# Fuzzy-find any window across all tmux sessions and jump to it.

list_windows() {
  local current=""
  if [ -n "${TMUX:-}" ]; then
    current=$(tmux display-message -p '#{window_id}')
  fi
  local tab
  tab=$(printf '\t')
  # Most recently used first; the current window is left out so enter jumps back.
  tmux list-windows -a \
    -F "#{window_activity}$tab#{window_id}$tab#{session_id}$tab#{session_name}$tab#{window_name}" \
    | sort -t "$tab" -k1,1nr \
    | awk -F '\t' -v cur="$current" '$2 != cur {
        printf "%s:%s\t\033[38;2;137;180;250m%s\033[0m\t%s\n", $3, $2, $4, $5
      }'
}

if [ "${1:-}" = "--list" ]; then
  list_windows
  exit 0
fi

self="$0"
target=$(
  list_windows | fzf --tmux 80%,70% \
    --delimiter '\t' --with-nth 2,3 --accept-nth 1 --tiebreak index \
    --border-label ' windows ' --prompt '🪟  ' \
    --header '  enter jump  ^x kill  ^r rename' \
    --bind 'tab:down,btab:up' \
    --bind "ctrl-x:execute-silent(tmux kill-window -t {1})+reload($self --list)" \
    --bind "ctrl-r:execute(printf 'rename to: '; read -r name; [ -n \"\$name\" ] && tmux rename-window -t {1} \"\$name\")+reload($self --list)" \
    --preview-window 'right:55%' \
    --preview 'tmux capture-pane -ep -t {1}'
) || exit 0

if [ -n "${TMUX:-}" ]; then
  tmux switch-client -t "$target"
else
  tmux select-window -t "$target"
  tmux attach-session -t "${target%%:*}"
fi
