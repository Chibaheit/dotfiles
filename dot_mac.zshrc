# --------------------- ENV ---------------------
# Encoding
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
# _____________________ ENV _____________________
alias clip="nc localhost 8377"
alias op="open"
# function alias
function mag2torrent {
  aria2c --bt-metadata-only=true --bt-save-metadata=true --enable-dht --input-file='' --listen-port=6881 "$1"
}
# --------------------- fzf ---------------------
__fzf_mdfind() {
  mdfind "kind:folder" \
    | fzf --tac --reverse --preview "$_tree_cmd {} | head -200"  --preview-window right:30%
}

__fzf_mdfind_arg() {
  __fzf_mdfind | while read item; do printf ' %q/' "$item"; done
}

__fzf_mdfind_arg_widget() {
  LBUFFER="${LBUFFER}$(__fzf_mdfind_arg)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N __fzf_mdfind_arg_widget
# fzf mdfind arg
bindkey '^[w' __fzf_mdfind_arg_widget

__fzf_mdfind_cd_widget() {
  local dir=$(__fzf_mdfind) && cd $dir
  local ret=$?
  zle fzf-redraw-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N __fzf_mdfind_cd_widget
# fzf mdfind cd
bindkey '^w' __fzf_mdfind_cd_widget

# _____________________ fzf _____________________

# use coreutils and gnu-xxx without 'g' prefix
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH:/usr/local/opt/gettext/bin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
unset _POWERLINE_SAVE_WIDGET
