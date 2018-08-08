# load MASS package to get galaxies data
library(MASS)

# Plot data
plot( galaxies )
hist( galaxies )

# bootstrap the mean statistic for the galaxies

means <- numeric( length = 1000 )
# repeat many times
for( i in 1:1000 ){
  # resample the data (as an approximation to the population)
  sam <- sample( galaxies, size = length( galaxies ), replace = TRUE )
  # calculate our statistic of interest (mean)
  means[i] <- mean( sam )
}
# done repeating
# look at histogram of statistic
hist( means )
# calculate standard error of statistic
sd( means )
# calculate 95% confidence interval
quantile( means, probs = c(0.025, 0.975) )
# get bias estimate
mean( galaxies )
mean( means )
