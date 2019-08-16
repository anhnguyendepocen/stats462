### lab 9

library(DAAG)

## 12.1
# Carry out the PCA of section 12.1.2, separately for males and females. For each of the first and second principle components, plot the loadings for females againt the loadings for all data combined, and similarly for males. Are there any striking differences?

# we are using the possum data set. Here's the structure
str(possum)

pairs(possum)

malepos = possum[possum$sex=="m", ]
femalepos = possum[possum$sec=="f"]

mpca = princomp(na.omit(malepos[, 6:14]))


                
library(MASS)

str(painters)

pairs(painters)

# Euclidean distance matrix
d.painters = dist(painters[, -5])

sammon(d.painters, k=2)
