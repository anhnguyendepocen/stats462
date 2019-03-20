### lab 6
library(MPV)
library(lattice)


# take a look at the structure of the data frame
str(table.b3)

## (a) plot the x1 and y data
with( data = table.b3, plot(x1, y))

## (b) using xyplot, plot the table's x1 values but coloured by group
xyplot(y ~ x1, data = table.b3, groups = x11, auto.key = TRUE, xlab="engine displacement", ylab="Miles per gallon")

## (c) note that this and the line below give the same answer!
lm( y ~ 1 + x1 + x11 + x1:x11, data = table.b3 )

fit = lm( y ~ x1*x11, data = table.b3 ) # this is another way to fit two lines at the same time. When x11 = 0 

# plot the fit and you'll get 4 different plots (need to press enter to get through them)
plot(fit)

## (d) plot residuals vs variable x7
xyplot(fit$residuals ~ x7, data=table.b3, groups=x11, auto.key = TRUE)


## extra work for graduate students
library(MCMCpack)

# do a Bayesian analysis version of regression, using the default priors from MCMCregress
b3MCMC = MCMCregress(formula = y ~ x1*x11, data=table.b3)

# plot the result b3MCMC, which is an mcmc object
plot(b3MCMC)

# check out the summarized results for the Bayesian analysis
summary(b3MCMC)

#... and compare to the linear model fit
summary(fit)
