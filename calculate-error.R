#!/usr/local/bin/Rscript
# Calculate the mean absolute error of the predictions.

train.y <- read.table('data/train-y.tab', header=T)
colnames(train.y) <- c('id', 'y')
train.yhat <- read.table('data/train-yhat.tab')
colnames(train.yhat) <- 'yhat'
test.y <- read.table('data/test-y.tab', header=T)
colnames(test.y) <- c('id', 'y')
test.yhat <- read.table('data/test-yhat.tab')
colnames(test.yhat) <- 'yhat'

train.data <- cbind(train.y, train.yhat)
train.data$abs.error <- abs(train.data$yhat - train.data$y)
test.data <- cbind(test.y, test.yhat)
test.data$abs.error <- abs(test.data$yhat - test.data$y)

cat(mean(train.data$abs.error), mean(test.data$abs.error))
cat('\n')
