#!/bin/sh
set -e
cd /home/keiyy/Documents/birthday

PROFILE=".preview/profile"
mkdir -p "$PROFILE"

shoot() {
  timeout 90 firefox --headless --no-remote --profile "$(pwd)/$PROFILE" \
    --window-size="$2" --screenshot "$(pwd)/.preview/$1" \
    "file:///home/keiyy/Documents/birthday/index.html" 2>&1 | tail -3 || true
  sleep 1
}

shoot closed.png "1280,900"
ls -la .preview/*.png 2>/dev/null || echo "no png produced"
