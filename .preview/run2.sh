#!/bin/sh
set -e
cd /home/keiyy/Documents/birthday

BASE='<base href="file:///home/keiyy/Documents/birthday/">'
INJECT='<style>*{transition:none!important;animation:none!important}</style><script>document.addEventListener("DOMContentLoaded",function(){var c=document.getElementById("card");c.classList.add("is-open");var l=document.getElementById("letter");l.inert=false;l.setAttribute("aria-hidden","false");});</script>'

sed "s|<head>|<head>${BASE}|" index.html > .preview/open.html
sed -i "s|</body>|${INJECT}</body>|" .preview/open.html

PROFILE="$(pwd)/.preview/profile"
mkdir -p "$PROFILE"

shoot() {
  timeout 90 firefox --headless --no-remote --profile "$PROFILE" \
    --window-size="$3" --screenshot "$(pwd)/.preview/$2" "file://$1" 2>&1 | tail -2 || true
  sleep 1
}

shoot "$(pwd)/index.html" "closed.png" "1280,900"
shoot "$(pwd)/.preview/open.html" "open-desktop.png" "1280,900"
shoot "$(pwd)/.preview/open.html" "open-mobile.png" "375,740"
shoot "$(pwd)/index.html" "closed-mobile.png" "375,740"

ls -la .preview/*.png
