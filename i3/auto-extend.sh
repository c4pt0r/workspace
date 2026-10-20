#!/bin/bash
# Watch DRM hotplug events and automatically extend the desktop onto any
# external monitor (Type-C / DP / HDMI) when it is plugged in.
#
# Usage:
#   auto-extend.sh            # daemon: apply once, then watch udev events
#   auto-extend.sh --once     # apply current layout and exit
#
# Env:
#   AUTO_EXTEND_POS   above | below | left-of | right-of   (default: above)
#   AUTO_EXTEND_INTERNAL  internal panel name             (default: eDP-1)

POS="${AUTO_EXTEND_POS:-above}"
INTERNAL="${AUTO_EXTEND_INTERNAL:-eDP-1}"
WALLPAPER="$HOME/.config/i3/wallpaper-great-wave-2560x1600.jpg"
LOCK="${XDG_RUNTIME_DIR:-/tmp}/auto-extend.lock"

log() { logger -t auto-extend -- "$*"; }

# Print the preferred mode of output $1 (or its first mode) from xrandr --query on stdin.
best_mode() {
    awk -v out="$1" '
        $1 == out { inside = 1; next }
        inside && /^[^ ]/ { exit }
        inside && $1 ~ /^[0-9]+x[0-9]+/ {
            if (!first) first = $1
            if ($0 ~ /\+/) { print $1; found = 1; exit }
        }
        END { if (!found && first) print first }'
}

apply() {
    local q connected=() stale=() name status
    q=$(xrandr --query)

    while read -r name status _; do
        [ "$name" = "$INTERNAL" ] && continue
        if [ "$status" = connected ]; then
            connected+=("$name")
        else
            stale+=("$name")
        fi
    done < <(awk '$2 == "connected" || $2 == "disconnected" { print $1, $2 }' <<<"$q")

    local args=(--output "$INTERNAL" --auto --primary)
    local prev="$INTERNAL" rel="$POS" mode
    for name in "${connected[@]}"; do
        # Some monitors don't flag a preferred mode ("+"), so --auto may pick
        # a low resolution; fall back to the first (largest) listed mode.
        mode=$(best_mode "$name" <<<"$q")
        if [ -n "$mode" ]; then
            args+=(--output "$name" --mode "$mode" "--$rel" "$prev")
        else
            args+=(--output "$name" --auto "--$rel" "$prev")
        fi
        # Chain additional monitors horizontally after the first one.
        prev="$name"
        rel=right-of
    done
    # Turn off outputs that are unplugged but still hold a CRTC.
    for name in "${stale[@]}"; do
        grep -qE "^$name disconnected [0-9]+x[0-9]+\+" <<<"$q" && args+=(--output "$name" --off)
    done

    log "xrandr ${args[*]}"
    xrandr "${args[@]}" || log "xrandr failed"
    [ -f "$WALLPAPER" ] && feh --bg-fill "$WALLPAPER"
}

if [ "$1" = "--once" ]; then
    apply
    exit
fi

# Single instance (i3 restarts would otherwise spawn duplicates).
exec 9>"$LOCK"
flock -n 9 || exit 0

apply

# udev emits a burst of "change" events per hotplug; debounce them.
udevadm monitor --udev --subsystem-match=drm | while read -r line; do
    [[ "$line" == *change* ]] || continue
    while read -r -t 1.5 _; do :; done
    sleep 0.5
    apply
done
