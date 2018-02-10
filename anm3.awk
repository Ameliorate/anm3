{
	"xdotool getactivewindow getwindowname" | getline W_TITLE
	"ps -p $(xdotool getactivewindow getwindowpid) -o comm=" | getline W_COMMAND
	close("xdotool getactivewindow getwindowname")
	close("ps -p $(xdotool getactivewindow getwindowpid) -o comm=")
}

# Presses a key for an instantanious moment.
# button - From `man xdotool`:
#          Type a given keystroke. Examples being "alt+r", "Control_L+J", "ctrl+alt+n", "BackSpace".
#          Generally, any valid X Keysym string will work. Multiple keys are separated by '+'.
#          Aliases exist for "alt", "ctrl", "shift", "super", and "meta" which all map to Foo_L, such as Alt_L and Control_L, etc.
#
# dont_clearmodifiers - Makes it such that the keystroke pressed in `button` is combined with the modifier keys pressed by the user.
#
# delay - "Delay between keystrokes. Default is 12ms."
#          I don't know what that means either.
function key(button, dont_clearmodifiers, delay,     options) {
	options = "--clearmodifiers"
	if (dont_clearmodifiers) {
		options = ""
	}
	if (delay) {
		options = options " --delay " delay
	}

	system("xdotool key " options " " button)
}
