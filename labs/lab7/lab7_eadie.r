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

geofits = lm(formula = thickness ~ poly(distance, degree=3), data = geophones)

with(geophones, plot(thickness~distance))

# create a new data frame that contains the values used in the regression
newdf = geophones
newdf$thickness = predict.lm(object = geofits)

with(newdf, lines(thickness~distance, lty=2, col="blue"))

summary(geofits)
par(mfrow = c(2,2))
plot(geofits)
