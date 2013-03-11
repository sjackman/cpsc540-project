# Optimize parameters of a machine learning model

from __future__ import division
from numpy import arange
import os

# Parameters
l1 = 1.7e-7
l2 = 0
xs = range(40, 70, 10) # passes

def removef(path):
	try:
		os.remove(path)
	except OSError:
		pass

e = []
for passes in xs:
	print '==> lambda_1=%g lambda_2=%g passes=%u <==' % (l1, l2, passes)
	removef('data/model.vw')
	cmd = 'make l1=%g l2=%g passes=%u data/model.vw data/error.tab' % (l1, l2, passes)
	print cmd
	os.system(cmd)
	f = open('data/error.tab', 'r')
	e.append(f.readline().split())
	print e[-1]

print "\nl1\tl2\tpasses\te_train\te_test"
for passes, e in zip(xs, e):
	print "%g\t%g\t%u\t%s\t%s" % (l1, l2, passes, e[0], e[1])
