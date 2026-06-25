#!/usr/bin/env sh
# Run php-fpm in the foreground (-F) so it keeps the container's inherited
# stdout/stderr instead of self-daemonizing and closing them to /dev/null.
# Backgrounded here so run.sh continues to exec nginx; php-fpm reparents to PID 1.
"$PHP_FPM_BIN" -F &

# Wait for the listen socket, then fail fast (aborts run.sh before nginx starts).
i=0
while [ ! -S "$PHP_FPM_SOCK_PATH" ] && [ "$i" -lt 50 ]; do
  sleep 0.1
  i=$((i+1))
done
[ -S "$PHP_FPM_SOCK_PATH" ] || { echo "[!] php-fpm failed to create $PHP_FPM_SOCK_PATH" >&2; exit 1; }
