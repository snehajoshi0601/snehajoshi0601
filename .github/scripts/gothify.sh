#!/usr/bin/env bash
# Repaints the generated game SVGs in the README's black & pink palette.
# Runs inside the GitHub Action after the games are generated into ./dist
set -euo pipefail
cd "${1:-dist}"

# ── arcade games (pac-man, breakout …): swap GitHub greens for pinks ──
for f in *-contribution-graph-dark.svg; do
  [ -f "$f" ] || continue
  sed -i -E \
    -e 's/#161b22/#1c0b15/gI' \
    -e 's/#0e4429/#4a0f2e/gI' \
    -e 's/#006d32/#8c1650/gI' \
    -e 's/#26a641/#d6246e/gI' \
    -e 's/#39d353/#ff6eb4/gI' \
    -e 's/#0d1117/#07030a/gI' \
    -e 's/#8b949e/#ff8cc6/gI' \
    -e 's/(id="w[hv]-[^"]*"[^>]*fill=")#ffffff/\1#ff4fa3/gI' \
    -e '0,/<svg width="([0-9.]+)" height="([0-9.]+)"/s//<svg viewBox="0 0 \1 \2" width="\1" height="\2"/' \
    "$f"
done

# breakout's ball & paddle: white → blush pink
for f in breakout-contribution-graph-dark.svg; do
  [ -f "$f" ] && sed -i -e 's/#ffffff/#ffc7e2/gI' "$f"
done

# ── snake: give it the same black card background ──
for f in snake*.svg; do
  [ -f "$f" ] || continue
  sed -i -e '0,/<desc>/s//<rect x="-16" y="-32" width="100%" height="100%" rx="14" fill="#07030a"\/><desc>/' "$f"
done
echo "gothified ✦"
