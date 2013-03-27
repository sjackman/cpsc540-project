#!/usr/bin/python
# Convert CSV to tab delimited.

import csv, sys

#csv.field_size_limit(1000000)
reader = csv.reader(sys.stdin)
for line in reader:
	print '\t'.join(line)
