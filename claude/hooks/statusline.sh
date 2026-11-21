#!/bin/bash
# ステータスライン: context の使用率・model・作業中のディレクトリと git のブランチを 1 行で出す。
# Claude Code が標準入力に渡す JSON を読む。
#
# 使用率が閾値以上になったら compact-prep を促す合図のファイルを書く。
# 合図のファイルは UserPromptSubmit の hook が読んで消し、「知らせた」の印を作る。
# 「知らせた」の印は PostCompact の hook が消す。印がある間は合図を書き直さない。

set -uo pipefail

input=$(cat)

jq_get() { printf '%s' "$input" | jq -r "$1" 2>/dev/null; }

session_id=$(jq_get '.session_id // empty')
model=$(jq_get '.model.display_name // .model.id // "?"')
cwd=$(jq_get '.workspace.current_dir // .cwd // empty')
ctx_size=$(jq_get '.context_window.context_window_size // empty')

# 使用率: used_percentage があればそれを使い、無ければ直近の要求の入力の token 数から計算する
pct=$(jq_get '.context_window.used_percentage // empty')
used=$(jq_get '(.context_window.current_usage // {}) | ((.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0))')
if [ -z "$pct" ] && [ -n "$ctx_size" ] && [ "${ctx_size:-0}" -gt 0 ] 2>/dev/null; then
  pct=$(( ${used:-0} * 100 / ctx_size ))
fi
int_pct=${pct%%.*}

human() {
  local n=${1:-0}
  if [ "$n" -ge 1000000 ] 2>/dev/null; then
    awk -v n="$n" 'BEGIN { v = n / 1000000; if (v == int(v)) printf "%dM", v; else printf "%.1fM", v }'
  elif [ "$n" -ge 1000 ] 2>/dev/null; then
    printf '%dk' $(( n / 1000 ))
  else
    printf '%s' "$n"
  fi
}

if [ -n "$int_pct" ]; then
  ctx="ctx ${int_pct}%"
  if [ -n "$ctx_size" ] && [ "${used:-0}" -gt 0 ] 2>/dev/null; then
    ctx="$ctx ($(human "$used")/$(human "$ctx_size"))"
  fi
else
  ctx="ctx -"
fi

dir=""
if [ -n "$cwd" ]; then
  dir=$(basename "$cwd")
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  [ -n "$branch" ] && dir="$dir ($branch)"
fi

line="$ctx | $model"
[ -n "$dir" ] && line="$line | $dir"
printf '%s\n' "$line"

# 閾値以上で compact-prep を促す合図のファイルを書く (知らせた後なら書かない)
COMPACT_WARN_THRESHOLD=60
if [ -n "$session_id" ] && [ -n "$int_pct" ] && [ "$int_pct" -ge "$COMPACT_WARN_THRESHOLD" ] 2>/dev/null; then
  _warn_dir="${TMPDIR:-/tmp}/claude-compact-warned"
  if [ ! -f "$_warn_dir/$session_id" ]; then
    _ctx_warn_dir="${TMPDIR:-/tmp}/claude-compact-warn"
    mkdir -p "$_ctx_warn_dir" 2>/dev/null || true
    printf '%s\n' "$int_pct" > "$_ctx_warn_dir/$session_id" 2>/dev/null || true
  fi
fi

exit 0
