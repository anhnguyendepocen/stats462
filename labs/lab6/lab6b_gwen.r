library(DAAG)
library(MASS)

############ quesiton 6.8 (a)

# lm.ridge fits a linear model by ridge regression
# apply the lm.ridge function to the litters data
# lambda is the tuning parameter in lm.ridge
ridge = lm.ridge(brainwt ~ bodywt + lsize, data=litters, lambda = seq(0,1, by=0.01))
 
# look at the coefficients
ridge$coef

# using GCV to choose the tuning parameter
with(ridge, plot(lambda, GCV))

# find the lambda that minimixes GCV, save that value and use for lm.ridge
lam = as.numeric( names( which.min(ridge$GCV) ) )

# add to plot to check
abline(v=lam)
# looks like minimum 

# now rerun ridge to get the result we care about
ridge = lm.ridge(brainwt ~bodywt + lsize, data = litters, lambda = lam)

coef(ridge)

# now run regular lm
regular = lm(brainwt ~ bodywt + lsize, data = litters)

regular$coefficients


# RESULT: coefficients are different, which the coefficient for lsize being the most different


############ question 6.8 (b)
# Estimate the mean brain weight when litter size is 10 and body weight is 7. Use the bootstrap with case-resampling, to compute approx. 90% percentile confidence intervals using each method. Compare wit the interval obtained using predict.lm

# predict brain weight given litter size = 10 and body weight is 7
predict.lm(object = regular, newdata = data.frame(lsize=10, bodywt = 7))


# regular regression with 95% percentile confidence intervals
calc.predict = function(simdata, index){
  
  prediction = predict.lm( object = lm(brainwt ~ bodywt + lsize, data = simdata, subset = index), newdata = data.frame(lsize=10, bodywt=7 ) )

  prediction  
  
}

# make an empty vector
results = numeric(length = 500)

for(i in 1:500){
  
  results[i] = calc.predict(simdata = litters, index = sample(1:nrow(litters), replace = TRUE, size = nrow(litters)) )
  
}

quantile(results, probs = c(0.025, 0.975))
plot(density(results))

# write a function to predict for new 
predicts = function(simdata,  index){
  
  # get the coefficients for the fit
  coeffs = coef( lm.ridge(brainwt ~ bodywt + lsize, data = simdata, subset = index) )

  prediction = coeffs%*%c(1, 7, 10)
  
  prediction
  
}


# do the bootstrap for the ridge regression
ridgeresults = numeric(length = 1000)

for(i in 1:1000){
  
  ridgeresults[i] = predicts(simdata = litters, index = sample(1:nrow(litters), replace = TRUE, size = nrow(litters)) )
  
}

# calculate the 95% confidence regions
quantile(ridgeresults, probs=c(0.025,0.975))

plot(density(ridgeresults))
