#!/usr/bin/python
# Convert CSV to tab delimited.

import csv, sys

reader = csv.reader(sys.stdin)
for line in reader:
	print '\t'.join(line)
