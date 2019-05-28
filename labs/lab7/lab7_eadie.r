library(DAAG)

toycars$car <- as.factor(toycars$car)

with(toycars, plot(x = angle, y=distance, col=car, pch=c(17,18,19), main="Toy Cars Rule" ))

# because car is a factor, it will make the design matrix for you, with two extra columns in addition to the default intercept
fitlines = lm(formula = distance ~ angle + car, data = toycars)

coefs = fitlines$coefficients

abline(a = coefs[1], b = coefs[2], col=toycars$car[1])
abline(a = coefs[3]+coefs[1], b = coefs[2], col=toycars$car[2])
abline(a = coefs[4]+coefs[1], b = coefs[2], col=toycars$car[3])

grid()

dev.off()

# (b) 
summary(fitlines)

### this is what R^2 is:
# Multiple R-squared:  0.9451,	Adjusted R-squared:  0.938 

# Multiple R-squared = 1 - var(residuals)/var(response variable)
# so a value of R-squared close to 1, means that there is little variance in the residuals compared to the response (data). This means the line is fitting pretty well.

# The adjusted R^2 value is the same kind of thing, but penalizes for any additional variables. E.g., if a variable was added, but didn't account for unexplained variance, then the adjusted R^2 value would go down.

# EXAMINE DIAGNOSTIC PLOTS
par(mfrow = c(2,2))

plot(fitlines)

# It looks like point 17 is an influential outlier

test = toycars[-17, ]
fittest = lm(formula = distance ~ angle + car, data = test)

testcoefs = fittest$coefficients

with(test, plot(x = angle, y=distance, col=car, pch=c(17,18,19), main="Toy Cars Rule" ))

abline(a = testcoefs[1], b = testcoefs[2], col=test$car[1])

abline(a = testcoefs[3]+testcoefs[1], b = testcoefs[2], col=test$car[2])
abline(a = testcoefs[4]+testcoefs[1], b = testcoefs[2], col=test$car[3])

fittest
grid()

# (c)
newfit = lm(formula = distance ~ car:angle, data = toycars)

with(toycars, plot(x = angle, y=distance, col=car, pch=c(17,18,19), main="Toy Cars Rule" ))

grid()
 
newcoefs = newfit$coefficients

abline(a = newcoefs[1], b = newcoefs[2], col=toycars$car[1])
abline(a = newcoefs[1], b = newcoefs[3], col=toycars$car[2])
abline(a = newcoefs[1], b = newcoefs[4], col=toycars$car[3])


# new R^2 values
# Multiple R-squared:  0.9413,	Adjusted R-squared:  0.9336 
# Maximizing R^2 doesn't guarantee the best model fit!

par(mfrow=c(2,2))
plot(newfit)

#################
# 7.7

str(geophones)

# fit a cubic polynomial
geofits = lm(formula = thickness ~ poly(distance, degree=4), data = geophones)

par(mfrow=c(1,1))
with(geophones, plot(thickness~distance))

# create a new data frame that contains the values used in the regression
newdf = geophones
newdf$thickness = predict.lm(object = geofits)

with(newdf, lines(thickness~distance, lty=2, col="purple"))

summary(geofits)
par(mfrow = c(2,2))
plot(geofits)

#################
# 7.8

# ns() Description from help file
# 
# Generate the B-spline basis matrix for a natural cubic spline.
# 
# Usage
# 
# ns(x, df = NULL, knots = NULL, intercept = FALSE,
#    Boundary.knots = range(x))

# do spline regression for 4, 5, and 6 degrees of freedom
splinefit4 = with(geophones, lm(thickness ~ ns(distance, df=4)) )
splinefit5 = with(geophones, lm(thickness ~ ns(distance, df=5)) )
splinefit6 = with(geophones, lm(thickness ~ ns(distance, df=6)) )

# get the summary of the fits
summary(splinefit4)
summary(splinefit5)
summary(splinefit6)

# calculate y values for plotting, using predict()
y4  = predict(object = splinefit4)
y5  = predict(object = splinefit5)
y6  = predict(object = splinefit6)

# plot the data and the spline regresions
par(mfrow=c(1,1))
with(geophones, plot(thickness~distance))
grid()
lines(geophones$distance, y4, col="blue")
lines(geophones$distance, y5, col="red")
lines(geophones$distance, y6, col="darkgreen")
# add a legend
legend("topright", legend = c("4 dof", "5 dof", "6 dof"), col=c("blue", "red", "darkgreen"), lty=c(1,1,1))

# look at the diagnostic plots
par(mfrow=c(2,2))
plot(splinefit4)
plot(splinefit5)
plot(splinefit6)


# make function for finding the confidence intervals
CIcurves = function(form, data, lty=1, col=3, newdata=data.frame(rate=seq(from=50, to=175, by=25)) ){
  
  rates.lm = lm(form, data=data)
  x = newdata[, all.vars(form)[2]]
  hat = predict(rates.lm, newdata=newdata, interval="confidence")
  
  lines(spline(x, hat[, "fit"]))
  lines(spline(x, hat[, "lwr"]), lty=lty, col=col)
  lines(spline(x, hat[, "upr"]), lty=lty, col=col)
  
}

# reset plotting parameters to plot 1 plot
par(mfrow=c(1,1))

# plot the data
with(geophones, plot(thickness~distance))
grid()
# add the 95% confidence interval (which is the default in predict.lm when interval set to "confidence")
ConfInt = CIcurves(form = thickness~ns(distance, df = 5), data=geophones, newdata = geophones, col="purple", lty=3)

legend("topright", legend = c("spline regression with 5 dof", "95% CI"), lty=c(1,3), col=c("black", "purple"))



###############
# 8.2

str(head.injury)

headglm = glm(formula = clinically.important.brain.injury ~ . , data = head.injury, family = "binomial")

summary(headglm) 

thresh = qlogis(p = 0.025)

