/\/[+:\-][[:digit:]]\// {
	printf "Warning: Found regex that doesn't match the end of line at line %d:\n", NR
	print $0
	print "You should add a '$' character to the end of this regex so that it doesn't match larger numbers that start the same.\n"
}

