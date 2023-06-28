#!/bin/sh

set -eux

### application name
app="EmacsKicker.app"

### Change directory.
here=$(dirname $0)
cd "$here"

### Fix file attributes of application.
xattr -rc "$app"

### Set application icon.
### ref: https://stackoverflow.com/questions/8371790/
image="Icon.png"
icon="tmp.png"
rsrc="tmp.rsrc"
cp "$image" "$icon"
sips -i "$icon"
DeRez -only icns "$icon" > "$rsrc"
SetFile -a C "$app"
#touch $app/$'Icon\r'
Rez -append "$rsrc" -o "$app"/Icon?
SetFile -a V "$app"/Icon?
rm "$rsrc" "$icon"
#osascript -e 'tell application "Finder" to quit'
#osascript -e 'delay 2'
#osascript -e 'tell application "Finder" to activate'

### Report result.
set +x
echo ""
echo "[OK] setup finished successfully."
echo ""
