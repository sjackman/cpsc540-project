# Explore the data and predictions.

library(fitdistrplus)
library(hexbin)
library(lattice)

data <- read.table('data/all-y.tab', header=T)
colnames(data) <- c('id', 'y')
densityplot(~y, data)
densityplot(~log(y), data)
norm.fit <- fitdist(log(data$y), 'norm')
norm.fit$estimate
plot(norm.fit)

train.y <- read.table('data/train-y.tab', header=T)
colnames(train.y) <- c('id', 'y')
train.yhat <- read.table('data/train-yhat.tab')
colnames(train.yhat) <- 'yhat'
test.y <- read.table('data/test-y.tab', header=T)
colnames(test.y) <- c('id', 'y')
test.yhat <- read.table('data/test-yhat.tab')
colnames(test.yhat) <- 'yhat'

train.data <- cbind(train.y, train.yhat)
summary(train.data$y)
summary(train.data$yhat)
histogram(~ y + yhat, train.data)
train.data$abs.error <- abs(train.data$yhat - train.data$y)
summary(train.data$abs.error)

test.data <- cbind(test.y, test.yhat)
test.data$error <- test.data$yhat - test.data$y
summary(test.data$error)
histogram(test.data$error, nint=25)

test.data$abs.error <- abs(test.data$yhat - test.data$y)
summary(test.data$abs.error)
histogram(test.data$abs.error, nint=25)

densityplot(~ y + yhat, test.data, auto.key=T, plot.points=F)
hexbinplot(yhat ~ y, test.data)
