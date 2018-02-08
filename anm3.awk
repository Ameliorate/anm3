BEGIN {
	"xdotool getactivewindow getwindowname" | getline W_TITLE
	"ps -p $(xdotool getactivewindow getwindowpid) -o comm=" | getline W_COMMAND
}

