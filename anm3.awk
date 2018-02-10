{
	"xdotool getactivewindow getwindowname" | getline W_TITLE
	"ps -p $(xdotool getactivewindow getwindowpid) -o comm=" | getline W_COMMAND
	close("xdotool getactivewindow getwindowname")
	close("ps -p $(xdotool getactivewindow getwindowpid) -o comm=")
}

