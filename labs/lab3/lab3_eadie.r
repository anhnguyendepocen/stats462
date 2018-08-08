# Gwen Eadie
# lab 3

library(DAAG)

##### 2.3

# check the structure of the possum data
str(possum)

pdf(filename = "q2-3_hist.pdf" )

hist(x = possum$earconch, xlab="earconch")
box()

# boxplot of female and male earconch
plot(formula = earconch ~ sex, data = possum)

# the measurement distributions differ in their median with the female earconch having a higher median than the male earconch. However, overall the ranges overlap a lot.

# I predict that the histograms look assymetric, with the females having a long tail towards lower values, and the males having a long tail towards higher values

# plot the females' earconch distribution
plot(density(possum$earconch[possum$sex=="f"]), xlab = "earconch", main="Female Earconch Distribution")

# plot the females' earconch distribution
plot(density(possum$earconch[possum$sex=="m"]), xlab = "earconch", main="Male Earconch Distribution")

#weird, they are both bimodal... maybe because of age?
plot(density(na.omit(possum$age)))

