# lab 6

### 5.5 
# In data set pressure
library(datasets)

str(pressure)

# plot it to check out what's what
plot(pressure)
dev.off()

library(MASS)

# naively fit a linear model to the data
linmod = lm(pressure~temperature, data = pressure)
summary(linmod)

# plot the data
plot(pressure)
# add the fit line
abline(linmod$coefficients, col="blue")
# add an informative legend
legend("topleft", lty = c(NA,1), col = c("black", "blue"), pch = c(1,NA), legend = c("data", "This is a terrible fit to the data!"))

## ^ we don't even need to plot the residuals to know that this fit is bad!

# Now use the boxcox function to find an estimate of lambda for the boxcox transformation
bctrans = with(pressure, boxcox(pressure ~ temperature))

# find the value of lambda where the peak is maximized
lambda = bctrans$x[ which.max(x = bctrans$y) ]

# make a new column in the data frame pressure that holds the boxcox transformed values
pressure$boxtrans = (pressure$pressure^lambda - 1)/lambda

# now fit a linear model to the transformed values and the temperature
lmnew = with(pressure, lm(formula = boxtrans ~ temperature))


# calculate fit at each data point
pressure$fit = pressure$temperature*(lmnew$coefficients[2]) + lmnew$coefficients[1]
  
# plot the new fit, and the residuals
par(mfrow=c(2,1))

with(pressure, plot(temperature, boxtrans))
grid() # add a grid just to be fancy

# add line that was fit
abline(lmnew$coefficients, col="blue" )

# plot residuals
with(pressure, plot(temperature, boxtrans-fit, ylab="residuals"))
# add a horizontal line at 0 for reference
abline(h=0, lty=2)
grid()


### 5.10

simdata = function(x, mu=0, sigma=1){
  
  y = 2 + 3*x + rnorm(n = length(x), mean = mu, sd = sigma)
  
  data.frame(x, y)
  
}

# make two different types of experiments
# for the first, sample at evenly spaced x values
samp1 = simdata(x = seq(-1,1, length.out=10))
# for the second, sample only at the extreme ends
samp2 = simdata(x = c(rep(-1,5), rep(1,5)))

# fit a linear model to each, and see how they do
lm1 = lm(formula = samp1$y ~ samp1$x)
plot(samp1)
abline(lm1$coefficients, col="blue")
grid()


lm2 = lm(formula = samp2$y ~ samp2$x)
plot(samp2)
abline(lm2$coefficients, col="blue")
grid()

