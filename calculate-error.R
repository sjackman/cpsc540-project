# Calculate the mean absolute error of the predictions.

library(hexbin)
library(lattice)

salary <- read.table('data/train-salary.tab', header=T)
prediction <- read.table('data/train-prediction.tab', header=T)
data <- cbind(salary, prediction)
data$abs.error <- abs(data$Prediction - data$Salary)
summary(data$abs.error)
densityplot(data$abs.error)
hexbinplot(Prediction ~ SalaryNormalized, data)
