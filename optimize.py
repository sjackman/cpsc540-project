# Optimize parameters of a machine learning model

from __future__ import division
from numpy import arange
import os

# Optimize the L1 regularization parameter.
#l1s = [1e-8, 2e-8, 5e-8, 1e-7, 2e-7, 5e-7, 1e-6]
l1s = arange(1, 5, 0.1) * 1e-7

def removef(path):
	try:
		os.remove(path)
	except OSError:
		pass

e = []
for l1 in l1s:
	print '==> lambda_1 = %g <==' % l1
	removef('data/model.vw')
	cmd = 'make l1=%g data/model.vw data/error.tab' % l1
	print cmd
	os.system(cmd)
	f = open('data/error.tab', 'r')
	e.append(f.readline().split())
	print e[-1]

print "\nl1\te_train\te_test"
for l1, e in zip(l1s, e):
	print "%g\t%s\t%s" % (l1, e[0], e[1])
