#!/usr/local/bin/Rscript
# Output e^x for each x on standard input.
writeLines(as.character(
	exp(as.numeric(readLines('stdin')))))
