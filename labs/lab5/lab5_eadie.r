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

