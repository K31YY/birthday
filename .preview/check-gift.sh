#!/bin/sh
set -e
cd /home/keiyy/Documents/birthday

BASE='<base href="file:///home/keiyy/Documents/birthday/">'
INJECT='<style>*{transition:none!important;animation:none!important}.gift--pending{opacity:1!important;transform:none!important}</style><script>function bottom(){var s=document.querySelector(".letter__scroll");s.scrollTop=s.scrollHeight;}document.addEventListener("DOMContentLoaded",function(){var c=document.getElementById("card");c.classList.add("is-open");var l=document.getElementById("letter");l.inert=false;l.setAttribute("aria-hidden","false");bottom();});window.addEventListener("load",function(){bottom();requestAnimationFrame(bottom);setTimeout(bottom,300);});</script>'

sed "s|<head>|<head>${BASE}|" index.html > .preview/gift-open.html
sed -i "s|</body>|${INJECT}</body>|" .preview/gift-open.html

PROFILE="$(pwd)/.preview/profile"

shoot() {
  timeout 90 firefox --headless --no-remote --profile "$PROFILE" \
    --window-size="$2" --screenshot "$(pwd)/.preview/$1" "file://$(pwd)/.preview/gift-open.html" 2>&1 | tail -2 || true
  sleep 1
}

shoot "gift-desktop.png" "1280,900"
shoot "gift-mobile.png" "375,740"
shoot "gift-small.png" "320,568"

ls -la .preview/gift-*.png
