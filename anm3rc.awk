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
