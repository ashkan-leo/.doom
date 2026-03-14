#!/usr/bin/env bash
# Thin wrapper — the real script lives at ~/.config/doom/bin/doom-check
exec "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/../../bin/doom-check" "$@"
