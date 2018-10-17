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
