# Lab 4 
# Gwen Eadie
# #exercises from DAAG Chapter 3

###### 3.3
# Use function sample() to create four random permutations of numbers 1:7

# make a matrix to store the data. Each column is a block
blocks = matrix(data = NA, nrow = 7, ncol = 4)
colnames(blocks) = c("B1", "B2", "B3", "B4")

# fill the matrix 
for(i in 1:ncol(blocks)){
  blocks[, i] = sample(x = 1:7, size = 7, replace = FALSE)
}

# show what it looks like
blocks

###### 3.4

# generate random sample size of 100 from a normal distribution
y = rnorm(n = 100)

## (a)
mean(y)
sd(y)

## (b) create a loop create random samples, and calculate the mean and sd 25 times
ntimes = 25

# store the means in a vector called av
av = vector(length = ntimes)

for(i in 1:ntimes){
  y = rnorm(n=100)
  av[i] = mean(y)
}

# calculate the standard deciation of the means
sd(av)

## (c)
# write a function that does the calculations in part (b)
meansamples = function(x, samplesize){

  # vector to store the means
  av = vector(length = x)

  for(i in 1:x){
    # draw random sample of size n
    y = rnorm(n=samplesize)
    # calculate the mean and store it
    av[i] = mean(y)
  }
  
  av
  
}

# run the function a few times and then plot the distribution of each set of means
fewtimes = 18
meanlist = lapply(X = 1:fewtimes, FUN = function(z) meansamples(x = 25, samplesize = 100)) 

# name each item in the list, then turn the list into a data frame
names(meanlist) = paste("Sample", 1:fewtimes, sep=" ")
meanlist = as.data.frame(meanlist)

# make a boxplot for fun (las = 2 turns the x-axis labels on their side)
pdf("q3-4_boxplot_eadie.pdf", width=11, height=8.5)
boxplot(meanlist, las=2)
dev.off()

# ok, now make the density plot for each distribution
pdf("q3-4_densities_eadie.pdf", width=11, height=8.5)

par( mfrow = c(3,3))

for(i in 1:fewtimes){ 
  
  plot( density(meanlist[, i]), main=colnames(meanlist)[i] )

}


dev.off()


###### 3.11

# data for the poor rats that were given carcinogens
ratdat = c(87, 53, 72, 90, 78, 85, 83)

sampmean = mean(ratdat)
sampvar = var(ratdat)

# I would say that the Poisson model is not apprpriate, since the sample mean and sample variance are not near equal (variance is twice the mean)

# repeat this several times to see if the Poisson assumotion holds
samps = as.data.frame(matrix(NA, ncol = 2, nrow = fewtimes))
colnames(samps) = c("mu", "lambda")

for(i in 1:fewtimes){
  # randomly draw 7 numbers from a Poisson distribution with var = 78.3
  x = rpois(n = 7, lambda = 78.3)
  samps[i, "mu"] = mean(x)
  samps[i, "lambda"] = var(x)
}

# plot the difference between the sample mean and sample variance for each simulations experiement
pdf("q3-11_eadie.pdf")
plot(samps$mu-samps$lambda, ylab=expression(mu-lambda), xlab="simulation")
dev.off()



###### 3.13
