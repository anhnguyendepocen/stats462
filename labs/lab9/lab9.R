#12.1

library(DAAG)

# get males and females into 2 groups
pca = princomp(na.omit(possum[,6:14]))

males = possum[possum$sex == "m",]
females = possum[possum$sex == "f",]

male_pca = princomp(na.omit(males[,6:14]))
female_pca = princomp(na.omit(females[,6:14]))

summary(male_pca, loadings = TRUE, digits=2)
summary(female_pca, loadings = TRUE, digits=2)

par(mfrow=c(2,1))
plot(pca$loadings[,1], -1*male_pca$loadings[,1], ylim = c(-0.05,1), xlim = c(0,0.55), main = "PC1", ylab = "M/F Loading", xlab = "")
text(pca$loadings[,1], -1*male_pca$loadings[,1], rownames(pca$loadings), pos = 4)
points(pca$loadings[,1], -1*female_pca$loadings[,1], pch=18)
abline(a=0,b=1)
legend("topleft", legend = c("male", "female"), pch = c(19, 18))

plot(pca$loadings[,2], male_pca$loadings[,2], ylim = c(-1,1), main = "PC2", ylab = "M/F Loading", xlab = "Full Loading")
points(pca$loadings[,2], -1*female_pca$loadings[,2], pch=18)
text(pca$loadings[,2], male_pca$loadings[,2], rownames(pca$loadings), pos = 4)
abline(a=0,b=1)

# Interpretation:
#   Since we're interpreting each principle component as something loosely representing a combination of the original axes, we can look at the
#   high valued ones and look at how the male/female points different from the y=x line. As an example, PC1 seems to be dominated by total length
#   and foot length, but more so foot length for females. Head length is also strong, but more so for males. Maybe an interpretation is that this
#   component is length related, but mostly foot length for females, and head length for males.

# 12.4
library(MASS)

head(painters)

dist_painters = dist(painters[,-5])
sam_painters  = sammon(dist_painters)

