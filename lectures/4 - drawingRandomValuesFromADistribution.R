# Draw 10000 random Normal values
rx <- rnorm(10000,0,1)
# Check them
plot( density(rx) )
# Transform them to the probability scale
y <- pnorm( rx, 0, 1 )
# Check the y's - they should be uniform
plot( density(y, adjust=0.2) )
# And they are!

# OK, so what we have seen is that
# if we start from random Normals, and
# we "map" them to the probability scale
# using the cumulative Normal distribution,
# we get a uniform distribution.

# What if we go in "reverse"?
# Starting from random uniform values,
# we could "map" them to random Normals
# using the INVERSE cumulative Normal
# distribution.

# Draw random uniforms (0,1)
ry <- runif(10000,0,1)

# Transform them to the Normal scale
x <- qnorm( ry, 0, 1 )

# Check that we got random Normals
plot( density( x ) )

# Looks pretty good! Compare using qqplot
qqnorm( x )
qqline( x )

# This works for *any* distribution!
# Try a beta distribution
x.beta <- qbeta( ry, 3, 6 )
plot( density(x.beta) )
# Add on the theoretical density of beta
xx <- seq(0,1,0.01)
lines( xx, dbeta( xx, 3, 6 ), col = "blue" )
# Looks good!


