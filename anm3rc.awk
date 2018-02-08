@include "anm3.awk"
{
	print "line = " $0
	print "title = " W_TITLE
	print "command = " W_COMMAND 
}
