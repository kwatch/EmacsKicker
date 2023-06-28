EmacsKicker.app
===============

($Release: 0.1.0 $)


Overview
--------

EmacsKicker.app is a small macOS application to handle 'emacs://' URL schema.
This application invokes Emacs.app when you clicked 'emacs://' URL
(for example emacs://open?url=file://<file>&line=<number> ) in your browser.

This is very useful for web application development as you can open
program files in Emacs.app with just one click on your browser.

EmacsKicker.app is implemented in AppleScript and shell script, therefore
it will work on any macOS version and any CPU architecture.


Installation
------------

1. Download [zip file](https://github.com/kwatch/EmacsKicker/archive/refs/tags/v0.1.0.zip)
   from [download page](https://github.com/kwatch/EmacsKicker/tags) and unzip it.
2. Control-click (or Right-click) `Setup.command` script and select 'Open'.
   Confirmation dialog will be displayed, then click 'Open' button.
3. Move EmacsKicker.app to '/Applications' folder.
4. Double click EmacsKicker.app under '/Applications' folder to register
   'emacs://' custom URL.
5. (optional) Create a symbolic lik for `emacsclient` in the `/usr/local/bin`.

```console
[Terminal]$ sudo ln -s /Applications/Emacs.app/Contents/MacOS/bin/emacsclient /usr/local/bin/
[Terminal]$ /usr/local/bin/emacsclient --version
emacsclient 28.2
```

And, of course, you must install Emacs.app, and run `M-x server-start`.

Then confirm that you can open `emacs://` URL schema.

```console
[Terminal]$ open emacs://open?url=file://<filepath>&line=<number>
```


Internal Details
----------------

EmacsKicker.app just runs shell script
`/Applications/EmacsKicker.app/Contents/SharedSupport/bin/emacskicker`.
You can customize this script as you like.


How to Create a Hander App in macOS
-----------------------------------

1. In Finder: 'Applications' > 'Utilities' > 'Script Editor.app'.
2. Menu: 'File' > 'New...'
3. Write the AppleScript program to invoke shell script (see below).
4. Menu: 'File' > 'Save...'.
   Enter 'Name', select 'File format' as 'Application', and press 'Save' button.
5. Create shell script `<YourApp>.app/Contents/SharedSupport/bin/<script>`
   and make it executable by `chmod` command.
6. Edit `<YourApp>.app/Contents/Info.plist` and register custom URL schema (see below).
7. Copy '<YourApp>.app' to 'Applications' folder.

AppleScript:

```applescript
--
-- please replace '<script>' with your script name
--
on open location input
	set appdir to POSIX path of (path to current application) as string
	set scriptfile to appdir & "/Contents/SharedSupport/bin/<script>"
	do shell script scriptfile & " " & (quoted form of input)
end open location
```

Shell script:

```sh
#!/bin/sh

set -eu

if [ $# = 0 ]; then
  echo "Usage: <script> foobar://open?url=file://<file>&line=<number>"
  exit 1
fi

link="$1"
file=$(echo $link | sed -E 's/foobar:\/\/open\?url=file:\/\/([^&]+)&.*/\1/')
line=$(echo $link | sed -E 's/foobar:\/\/open\?[^&]+&line=([0-9]+).*/\1/')

code -g "$file:$line"    # VS Code (for example)
```

Make the script executable:

```console
[bash]$ chmod +x <YourApp>.app/Contents/SharedSupport/bin/<script>
```

Info.plit: (add the following to the top of `<dict>`)

```xml
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLName</key>
			<string>YourApp URL</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>foobar</string>
			</array>
		</dict>
	</array>
```


License and Copyright
---------------------

$License: MIT License $

$Copyright: copyright(c) 2023 kuwata-lab.com all rights reserved $
