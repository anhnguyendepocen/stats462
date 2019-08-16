library(DAAG)

# 4.1

#     The ‘nswdemo’ data frame contains 722 rows and 10 columns. These
#     data are pertinent to an investigation of the way that earnings
#     changed, between 1974-1975 and 1978, for an experimental treatment
#     who were given job training as compared with a control group who
#     did not receive such training.
#
#     trt a numeric vector identifying the study in which the subjects
#          were enrolled (0 = Control, 1 = treated).
#     age age (in years).
#     educ years of education.
#     black (0 = not black, 1 = black).
#     hisp (0 = not hispanic, 1 = hispanic).
#     marr (0 = not married, 1 = married).
#     nodeg (0 = completed high school, 1 = dropout).
#     re74 real earnings in 1974.
#     re75 real earnings in 1975.
#     re78 real earnings in 1978.

# 4.1a
# Use t test to get confidence interval for re75 as a function of trt
ci = with(nswdemo, t.test(re75~trt))
print("Confidence interval for real earnings in 1975 as a function of group:")
print(ci)

#4.1b

ci = with(nswdemo, t.test(re78~trt))
print("Confidence interval for real earnings in 1978 as a function of group:")
print(ci)

#4.1c
nswdemo$diff = nswdemo$re78 - nswdemo$re75
control = subset(nswdemo, trt==0)
helped = subset(nswdemo, trt==1)

ci = with(control, t.test(diff, paired=TRUE))
print("Confidence interval for difference in real earnings between 1978 and 1975 for control group:")
print(ci)

ci = with(helped, t.test(diff~trt))
print("Confidence interval for difference in real earnings between 1978 and 1975 for trained group:")
print(ci)

#4.8
# names: > [1] "trt"   "age"   "educ"  "black" "hisp"  "marr"  "nodeg" "re74"  "re75" "re78" 
#with(psid3, plot(age))
#plot(x,y1,type="l",col="red")
#lines(x,y2,col="green")

#4.9
#
# In order to test whether these results are different from the "expected", we can perform a chi-squared test (or a Fisher's Exact Test if n is small enough) to check how much our results vary from just distributing the counts according to row/column probabilities. e.g. P(i,j) (probability of being in cell i,j) = P(i) * P(j) (probability of column i times probability of row j). That is, do the distributions in each row/column match what you'd expect for summing rows and columns?

acup = matrix( c(74, 71, 43, 38, 11, 65), ncol=3, dimnames=list(c("LargeReduction", "SmallReduction"), c("Acupuncture", "Sham", "WaitingList")))
result = chisq.test(acup)
print(result)

# This gives us a result of p = 9e-8
# This implies that these items are likely *not independent*
# We can say something along the lines of "There isn't no relationship between these treatments."

# 4.14
#

library(boot)

z.transform = function(r) .5*log((1r)/(1-r))
z.inverse = function(z) (exp(2*z) -1)/(exp(2*z)1)
possum.fun = function(data, indices) {
    chest = data$chest[indices]
    belly = data$belly[indices]
    cor(belly, chest)
}
possum.boot = boot(possum, possum.fun, R=999)
print(boot.ci(possum.boot, type="perc")$percent[4:5])

possum.funz = function(data, indices) {
    chest = data$chest[indices]
    belly = data$belly[indices]
    z.transform(cor(belly, chest))}
possum.bootz = boot(possum, possum.funz, R=999)
print(z.inverse(boot.ci(possum.bootz, type="perc")$percent[4:5]))

# The transformation is useful for helping to create a symmetric distribution of the correlation coefficient at high correlations. If you didn't do this, the standard deviation of the correlation coefficient would get smaller as you got closer to one meaning you'd need to take a larger number of bootstrap samples to effectively sample the space between r (near 1) and 1. This allows you to sample that space more efficiently. If you simply plot the z distribution, you'll see it's not important for values of |z| ~< 0.75.

# 4.22

pair65$diff = pair65$heated - pair65$ambient

funlik = function(mu, sigma, x=with(pair65, heated-ambient))
  prod(dnorm(x, mu, sigma))

# What is sampel stddev? Asssume that for our values.
print("sample stddev: ", with(pair65, sd(diff)))

# Generate x/y pairs by calling funlik for multiple mu's
xvals = seq(-5, 25, by=0.1)
yvals = sapply(X = xvals, FUN = funlik, sigma=5.75)
plot(yvals, yvals)

# What we're seeing is the likelihood of x given that the true mu/sigma is what we passed in

prior = dnorm(xvals, mean=6, sd=5)

posterior = prior * yvals / sum(prior * yvals)
plot(xvals, prior, y="log")
lines(xvals, posterior)

# Can also get the posterior using eqs on pg 134 of DAAG
# Last question: Is it reasonable to view posterior as compromise between prior and likelihood? Yes, though better language might be
# "an updated estimate given new data".
