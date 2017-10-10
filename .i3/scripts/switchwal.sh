#!/bin/zsh

wal -n -i "$HOME/.wallpaper"
nitrogen --head=0 --set-zoom-fill "$(< "${HOME}/.cache/wal/wal")"
nitrogen --head=1 --set-zoom-fill "$(< "${HOME}/.cache/wal/wal")"
nitrogen --head=2 --set-zoom-fill "$(< "${HOME}/.cache/wal/wal")"