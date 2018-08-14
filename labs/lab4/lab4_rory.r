library(tcltk)
library(lattice)
library(zoo)

# 3.3

print("4 random permutations of 1-7:")
for(i in 1:4){
  print(sample(c(1,2,3,4,5,6,7),7))
}

# 3.4
y <- rnorm(100)
# a
print("Average and stddev of 100 random numbers:")
print(mean(y))
print(sd(y))
# b
av <- rep(c(0),25)
for(i in 1:25){
    av[i] = mean(rnorm(100))
}
print("Averages over 25 runs:")
print(av)
print("Stddev of averages:")
print(sd(av))

# c
random_averages <- function(){
    av <- rep(c(0),25)
    for(i in 1:25){
        av[i] = mean(rnorm(100))
    }
    plot(density(av))
}


#pdf(filename = "q3.4c.pdf" )
random_averages()
random_averages()
random_averages()
random_averages()
random_averages()

# 3.11
abnormal <- c(87, 53, 72, 90, 78, 85, 83)
print("Abnormal growths: mean:")
print(mean(abnormal))
print(var(abnormal))

# The variance of a poisson distribution is the mean
check_pois <- function(){
    x <- rpois(7, 78.3)
    print(mean(x))
    print(var(x))
}

# Show that here.
check_pois()
check_pois()
check_pois()
check_pois()
check_pois()
check_pois()

# Is the poisson assumption appropriate for this model? I'm not sure. The variance of that set is significantly larger than the mean. That said, in multiple runs of check_poisson(), I saw a couple have variances around 150. I would guess there's not enough data to be able to tell one way or the other.

#3.13

#from 3.12
Markov <- function(N=100, initial.value=1, P){
    X <- numeric(N)
    X[1] <- initial.value + 1
    n <- nrow(P)
    for (i in 2:N){
        X[i] <- sample(1:n, size=1, prob=P[X[i-1], ])
    }
    X - 1
}

P <- matrix(
    c(0.6, 0.2, 0.2, 0.2, 0.4, 0.4, 0.4, 0.3, 0.3),
    nrow=3,
    ncol=3,
    byrow = TRUE)

# a
vals <- table(Markov(N=1000, initial.value=0, P))
print("Percentage of time for each state:")
print(vals/1000)

# b

library(zoo)
#given function
plotmarkov <- function(n=10000, start=0, target=0, window=100, transition=Pb, npanels=5){
    xc2 <- Markov(n, start, transition)
    mav0 <- rollmean(as.integer(xc2==target), window)
    mav1 <- rollmean(as.integer(xc2==target), window)
    npanel <- cut(1:length(mav0), breaks=seq(from=1, to=length(mav0), length=npanels+1), include.lowest=TRUE)
    df <- data.frame(av0=mav0, av1=mav1, x=1:length(mav0), gp=npanel)
    print(xyplot(av0+av1 ~ x | gp, data=df, layout=c(1,npanels), type="l", par.strip.text=list(cex=0.65), scales=list(x=list(relation="free"))))
}


plotmarkov(window=10)
plotmarkov(window=50)
plotmarkov(window=100)
plotmarkov(window=300)
plotmarkov(window=500)
plotmarkov(window=1000, target=0)
plotmarkov(window=1000, target=1)
plotmarkov(window=1000, target=2)

# it seems like the stationary distribution is pretty evident by around a window size of 1000.
