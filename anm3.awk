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
function key(button, dont_clearmodifiers) {
       _generic_key("key", button, dont_clearmodifiers)
}

# Presses down a key until function `keyup` is called.
#
# delay - From `man xdotool`: "Delay between keystrokes. Default is 12ms." 
#	If button is 'a' then a will be typed every delay miliseconds.
#
# See function `key` for info about arguments
function keydown(button, dont_clearmodifiers, delay) {
	_generic_key("keydown", button, dont_clearmodifiers, delay)
}

# Unpresses a key pressed with function `keyup`
# button - See function `key`
function keyup(button) {
	_generic_key("keyup", button)
}

# Types the string given in text.
#
# text - The contents of this string are typed into the focused window
#
# See function `key` for more info about arguments.
function type(text, dont_clearmodifiers) {
	_generic_key("type", text, dont_clearmodifiers)
}

function _generic_key(command, button, dont_clearmodifiers, delay,     options) {
	options = "--clearmodifiers"
	if (dont_clearmodifiers) {
		options = ""
	}
	if (delay) {
		options = options " --delay " delay
	}

	system("xdotool " command " " options " " button)
}

# Automagically activate a keycombo that will be released when the button that triggered the current event is released.
# Must only be called when $0 starts with a +: The input event must be a button press.
# If magic_key is called while it is still active, the currently pressed key will be unpressed.
# This function elegantly handles the program ending abruptly.
#
# delay - The delay between when the button presses. 
# 	If button = 'a', then 'a' will be typed every delay miliseconds.
#
# See `key` for more info about arguments.
function magic_key(button, dont_clearmodifiers, delay) {
# Internal variables:
# _MAGIC_KEY_LOCK   - If magic_key is currently active.
# _MAGIC_KEY_BUTTON - The button active with magic_key.
	if ($0 !~ /+/) {
		printf "Error in magic_key(%s, %d, %d), not called on + event\n", button, dont_clearmodifiers, delay
		exit 1
	}
	if (_MAGIC_KEY_LOCK) {
		keyup(_MAGIC_KEY_BUTTON)
	}
	_MAGIC_KEY_LOCK = 1
	_MAGIC_KEY_BUTTON = button
	keydown(button, dont_clearmodifiers, delay)
}

{
	if (/-|+/ && _MAGIC_KEY_LOCK) {
		keyup(_MAGIC_KEY_BUTTON)
		_MAGIC_KEY_LOCK = 0
	}
	
}

END {
	if (_MAGIC_KEY_LOCK) {
		keyup(_MAGIC_KEY_BUTTON)
		_MAGIC_KEY_LOCK = 0
	}
}

