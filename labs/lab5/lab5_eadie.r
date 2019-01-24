# Stats 462/862, Lab 5

### 4.1 

library(DAAG)

summary(nswdemo)
structure(nswdemo)

# (a) 1975 mean incomes of each group
mu0 = mean(nswdemo$re75[nswdemo$trt==0])

nswpsid3 = rbind(psid3, subset(nswdemo, trt==1))

helped = subset(nswpsid3, trt==1)
control = subset(nswpsid3, trt==0)


par(mfrow=c(3,3))

for(i in 2:(length(colnames(control))) ){
  

  plot(density(na.omit(control[, i])), main=colnames(control)[i])
  lines(density(na.omit(helped[, i])), lty=2)
  
}

with(nswpsid3, table(trt, marr))


### 4.14

z.transform = function(r) 0.5*log( (1+r)/(1-r) )

z.inverse = function(z) (exp(2*z)-1)/(exp(2*z)+1)

possum.fun = function(data, indices){
  chest = data$chest[indices]
  belly = data$belly[indices]
  z.transform(cor(belly, chest) )
}

# arguments to boot are data, statistic
possum.boot = boot(possum, possum.fun, R=999)

possum.boot
z.inverse(boot.ci(possum.boot, type="perc")$percent[4:5])


possum.fun2 = function(data, indices){
  chest = data$chest[indices]
  belly = data$belly[indices]
  cor(belly, chest)
}

possum.boot2 = boot(possum, possum.fun2, R=999)


boot.ci(possum.boot2, type="perc")$percent[4:5]



## plot z transform
zvalues = z.transform(cor(possum$belly, possum$chest), xlim=c(-1,1) )


### 4.22

# assuming an independent normal errors model
funlik = function(mu, sigma, x=pair65$diff){
  prod(dnorm(x, mu, sigma))
}

# we are going to assume the estimate of sigma instead of estimating it
mysig = 5.75

# range of values for unknown mu
xvalues = seq(-50,50, by=0.1)

# calculate the likelihood for each mu value
yvalues = sapply(X = xvalues, FUN = funlik, sigma=mysig)

# plot the likeilihood
plot(xvalues, yvalues, xlab=expression(mu), ylab = expression(L(x|mu,sigma==5.75)))

# this is how you make a vertical line. You can make a horizontal line using "h=" instead of "v=". See ?abline for making arbitrary lines
abline(v=6.33, lty=2)


# this is how you turn off the plotting window
dev.off()

### this is the second part of the question, even though it isn't labeled as such

# prior distribution function
prior = function(x, mu=6, sigma=5){
  dnorm(x, mean = mu, sd = sigma)
}

# plot the prior distribution
plot(xvalues, prior(xvalues), lty=2, xlim=c(-50, 50))

# calculate the posterior distribution (remember to normalize)
postvalues = yvalues*prior(xvalues)/sum(yvalues*prior(xvalues))

# add the posterior distribution to the plot
lines(xvalues, postvalues, lty=2, col="blue")
dev.off()


# posterior mean
postmean = function(sigma, n = nrow(pair65), sampmean = mean(pair65$diff), mu0 = 6, sigma0 = 5){
  n*sampmean + mu0*sigma^2/sigma0^2 / ( n + sigma^2/sigma0^2 )
}

# posterior variance
postvar = function(sigma, n = nrow(pair65), sampmean = mean(pair65$diff), sigma0 = 5){
  sigma^2/(n + sigma^2/sigma0^2)
}


plot(xvalues, dnorm(xvalues, mean=postmean(5.75), sd = sqrt(postvar(5.75))))
