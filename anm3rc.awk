@include "anm3.awk"
{
	print "line = " $0
	print "title = " W_TITLE
	print "command = " W_COMMAND 
}

/-1/ {
	key("ctrl+c")
}

/-2/ {
	key("ctrl+v")
}

/+4/ {
	keydown("Prior")
}

/-4/ {
	keyup("Prior")
}

/+5/ {
	keydown("Next")
}

/-5/ {
	keyup("Next")
}

/+3/ {
	magic_key("a")
}

