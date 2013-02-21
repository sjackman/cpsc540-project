# Exploratory analysis of job postings

library(fitdistrplus)
library(lattice)

data <- read.table('data/Train-salary.tab', header=T)
densityplot(~SalaryNormalized, data)
densityplot(~log(SalaryNormalized), data)
norm.fit <- fitdist(log(data$SalaryNormalized), 'norm')
norm.fit$estimate
plot(norm.fit)
