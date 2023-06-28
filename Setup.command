#!/bin/sh

set -eux

### Change directory.
here=$(dirname $0)
cd "$here"

### Fix file attributes of application.
xattr -rc EditorKicker.app

### Set application icon.
### ref: https://stackoverflow.com/questions/8371790/
image="Icon.png"
appdir="EditorKicker.app"
icon="tmp.png"
rsrc="tmp.rsrc"
cp "$image" "$icon"
sips -i "$icon"
DeRez -only icns "$icon" > "$rsrc"
SetFile -a C "$appdir"
#touch $appdir/$'Icon\r'
Rez -append "$rsrc" -o "$appdir"/Icon?
SetFile -a V "$appdir"/Icon?
rm "$rsrc" "$icon"
#osascript -e 'tell application "Finder" to quit'
#osascript -e 'delay 2'
#osascript -e 'tell application "Finder" to activate'

### Report result.
set +x
echo ""
echo "[OK] setup finished successfully."
echo ""
