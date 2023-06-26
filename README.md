EmacsKicker.app
===============

($Release: 0.0.0 $)


Overview
--------

EmacsKicker.app is a small macOS application to handle 'emacs://' URL schema.
This application invokes Emacs.app when you clicked 'emacs://' URL
(for example emacs://open?url=file://<file>&line=<number> ).

This is very useful for web application development as you can open
program files in Emacs.app with just one click on your browser.

EmacsKicker.app is implemented in AppleScript and shell script, therefore
it will work on any macOS version.


Installation
------------

1. Download Zip file and unzip it.
2. Copy EmacsKicker.app to ``/Applications`` folder.
3. (optional) Create a symbolic lik for `emacsclient` in the `/usr/local/bin`.

```console
[bash]$ x=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
[bash]$ ls $x
/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
[bash]$ sudo ln -s $x /usr/local/bin
[bash]$ /usr/local/bin/emacsclient --version
emacsclient 28.2
```

And, of course, you must install Emacs.app, and run `M-x server-start`.

Then confirm that you can open `emacs://` URL schema.

```console
[bash] open emacs://open?url=file://<filepath>&line=<number>
```


Internal Detail
---------------

EmacsKicker.app just runs shell script
`/Applications/EmacsKicker.app/Contents/SharedSupport/bin/emacskicker`.
You can customize this script as you like.


License and Copyright
---------------------

$License: MIT License $

$Copyright: copyright(c) 2023 kuwata-lab.com all rights reserved $
