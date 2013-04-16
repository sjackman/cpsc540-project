#!/usr/local/bin/Rscript
# Calculate the mean absolute error of the predictions.

train.y <- read.table('data/train-y.tab', header=T)
colnames(train.y) <- c('id', 'y')
train.yhat <- read.table('data/train-yhat.tab')
colnames(train.yhat) <- 'yhat'
cross.y <- read.table('data/cross-y.tab', header=T)
colnames(cross.y) <- c('id', 'y')
cross.yhat <- read.table('data/cross-yhat.tab')
colnames(cross.yhat) <- 'yhat'

train.data <- cbind(train.y, train.yhat)
train.data$abs.error <- abs(train.data$yhat - train.data$y)
cross.data <- cbind(cross.y, cross.yhat)
cross.data$abs.error <- abs(cross.data$yhat - cross.data$y)

cat(mean(train.data$abs.error), mean(cross.data$abs.error))
cat('\n')
