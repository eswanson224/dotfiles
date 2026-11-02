#!/usr/bin/env bash
# Status line: cwd · branch · model · context · rate limits
# Parses stdin JSON with sed/grep only (no jq/python dependency).

input=$(cat | tr -d '\n')

# Print the balanced {...} object that follows the first "key": in the input.
obj() {
  awk -v key="\"$1\"" '{
    i = index($0, key); if (!i) exit
    s = substr($0, i + length(key)); j = index(s, "{"); if (!j) exit
    d = 0
    for (k = j; k <= length(s); k++) {
      c = substr(s, k, 1)
      if (c == "\"") { k++; while (k <= length(s) && (c = substr(s, k, 1)) != "\"") { if (c == "\\") k++; k++ } continue }
      if (c == "{") d++
      else if (c == "}" && --d == 0) { print substr(s, j, k - j + 1); exit }
    }
  }' <<<"$input"
}
pct() {
  grep -oE '"used_percentage"[[:space:]]*:[[:space:]]*[0-9.]+' <<<"$1" | head -n1 | grep -oE '[0-9.]+$'
}

dir=$(sed -n -E 's/.*"current_dir"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/p' <<<"$input")
[ -z "$dir" ] && dir=$(sed -n -E 's/.*"cwd"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/p' <<<"$input")
dir=${dir//\\\//\/}
[ -z "$dir" ] && dir=$PWD

disp=$dir
case "$dir" in
"$HOME") disp="~" ;;
"$HOME"/*) disp="~${dir#"$HOME"}" ;;
esac

branch=""
if [ -d "$dir" ]; then
  branch=$(git --no-optional-locks -C "$dir" symbolic-ref --short -q HEAD 2>/dev/null ||
    git --no-optional-locks -C "$dir" rev-parse --short HEAD 2>/dev/null)
fi

model=$(obj model | grep -oE '"display_name"[[:space:]]*:[[:space:]]*"[^"]*"' | head -n1 | sed -E 's/.*"([^"]*)"$/\1/')

ctx=$(pct "$(obj context_window)")

limits_obj=$(input=$(obj rate_limits) obj five_hour)
five=$(pct "$limits_obj")
limits_obj=$(input=$(obj rate_limits) obj seven_day)
week=$(pct "$limits_obj")

sep=" · "
out=$disp
[ -n "$branch" ] && out="$out$sep$branch"
[ -n "$model" ] && out="$out$sep$model"
[ -n "$ctx" ] && out="$out${sep}ctx $(printf '%.0f' "$ctx")%"

limits=""
[ -n "$five" ] && limits="5h $(printf '%.0f' "$five")%"
[ -n "$week" ] && limits="${limits:+$limits }7d $(printf '%.0f' "$week")%"
[ -n "$limits" ] && out="$out$sep$limits"

printf '%s' "$out"
