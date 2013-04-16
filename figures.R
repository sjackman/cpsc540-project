# Draw figures for the paper

library(lattice)

# Dimensions of the figures
res <- 300 # dpi
width <- 5.5 * dpi * 4/3
height <- 2.25 * dpi * 4/3

key <- list(corner=c(0.9,0.1), text=c('Training error', 'Validation error'))

data <- read.table('data/l1.tab', header=TRUE)
png('l1.png', width=width, height=height, res=res)
xyplot(e_train + e_test ~ l1, data,
	type='b', auto.key=key,
	#main='Optimizing the L1 regularization parameter',
	xlab='L1 regularizaton parameter',
	ylab='Mean absolute error (£)')
dev.off()

data <- read.table('data/nn.tab', header=TRUE)
png('nn.png', width=width, height=height, res=res)
xyplot(e_train + e_test ~ nn, data,
	type='b', auto.key=key,
	#main='Optimizing the number of neurons',
	xlab='Number of hidden-layer neurons',
	ylab='Mean absolute error (£)')
dev.off()

data <- read.table('data/nn-l1.tab', header=TRUE)
png('nn-l1.png', width=width, height=height, res=res)
xyplot(e_train + e_test ~ l1, data,
	type='b', auto.key=key,
	#main='Optimizing the L1 regularization parameter of the neural network',
	xlab='L1 regularizaton parameter',
	ylab='Mean absolute error (£)')
dev.off()

key <- list(corner=c(0.9,0.9), text=c('Training error', 'Validation error'))

data <- read.table('data/dropout-nn.tab', header=TRUE)
png('dropout-nn.png', width=width, height=height, res=res)
xyplot(e_train + e_test ~ nn, data,
	type='b', auto.key=key,
	#main='Optimizing the number of neurons',
	xlab='Number of hidden-layer neurons',
	ylab='Mean absolute error (£)')
dev.off()

data <- read.table('data/dropout-l1.tab', header=TRUE)
png('dropout-l1.png', width=width, height=height, res=res)
xyplot(e_train + e_test ~ l1, data,
	type='b', auto.key=key,
	#main='Optimizing the L1 regularization parameter of the dropout neural network',
	xlab='L1 regularizaton parameter',
	ylab='Mean absolute error (£)')
dev.off()
