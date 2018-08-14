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

# I would say that the Poisson model is not appropriate, since the sample mean and sample variance are not near equal (variance is twice the mean)

# repeat this several times to see if the Poisson assumotion holds
samps = as.data.frame(matrix(NA, ncol = 2, nrow = 1e3))
colnames(samps) = c("mu", "lambda")

for(i in 1:fewtimes){
  # randomly draw 7 numbers from a Poisson distribution with var = 78.3
  x = rpois(n = 7, lambda = 78.3)
  samps[i, "mu"] = mean(x)
  samps[i, "lambda"] = var(x)
}

# plot the difference between the sample mean and sample variance for each simulations experiement
pdf("q3-11_eadie.pdf")

plot(samps$mu, samps$lambda, ylab=expression(mu), xlab=expression(lambda))

dev.off()



###### 3.13

# the transition matrix for the Markov chain
Tmat = matrix(c(0.6, 0.2, 0.2, 0.2, 0.4, 0.4, 0.4, 0.3, 0.3), nrow = 3, ncol=3, byrow = TRUE)

# assign numbers to the states
sun = 1
cloud = 2
rain = 3

Markov = function(N, init, transmat, states=c(sun, cloud, rain)){
  
  # make empty chain
  chain = numeric(N)
  # current state
  chain[1] = init
  # number of states
  n = length(states)
  
  for(i in 2:N){
    oldstate = chain[i-1]
    # draw a new state given the previous state
    chain[i] = sample(x = 1:n, size = 1, prob = transmat[oldstate, ])
  }
  
  chain
  
}

chainlength = 1e3
samplechain = Markov(N = chainlength, init=2, transmat = Tmat)

sum(samplechain==1)/chainlength
sum(samplechain==2)/chainlength
sum(samplechain==3)/chainlength


###### extra
 # dwarf galaxies kinematics from aia DR2
 # Table D.2
# https://www.astro.rug.nl/~ahelmi/research/dr2-dggc/
 
dwarfs = read.csv(file = "../../../../Research/Data-tracers/Data/GaiaDR2_DGs/d2.csv")

apos = dwarfs$apocentre

pdf("extra-question_eadie.pdf")

plot(density(apos), main = "Density of DGs' apocenters", xlab = "kpc")

# does not appear normally distributed

# number of samples in data
n = length(apos)

mean(apos)
var(apos)

# look at the empirical distribution of the apocenters
plot(ecdf(x = apos))

# draw n samples with replacement
samps = sample(x = apos, size = n, replace = TRUE)

sampsmu = mean(samps)
sampsvar = var(samps)

# make a data frame
df = data.frame(sampsmu, sampsvar)

# do this over and over to get 1000 means and variances
for(i in 2:1000){

  samps = sample(x = apos, size = n, replace = TRUE)
  df[i, "sampsmu"] = mean(samps)
  df[i, "sampsvar"] = var(samps)
  
}

# plot the distribution of the means and variances
plot(density(df$sampsmu), main="Distribution of Sample Means")
plot(density(df$sampsvar), main="Distribution of Sample Variances")

# distribution of the means looks almost normal
# distribution of the variances do no look normal

dev.off()
