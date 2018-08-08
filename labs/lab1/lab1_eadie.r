# Lab 1, Eadie

# load the DAAG package (assuming already installed)
library(DAAG)

theserows = c(1, 2, 4, 11, 13, 18)

dat = orings[ theserows, ]

## 1.2

# plot total incidents versus temperature 
plot(dat$Temperature, dat$Total, ylab = "Total Incidents", xlab = "Temperature", pch=19)
grid()

# makes pairs plots to show relationship between the all components of the data 
pairs(dat)

## 1.3
str(possum)

# logical vector giving the INcomplete rows
incompleterows = !complete.cases(possum)

# print these rows
print(possum[incompleterows, ])

# missing values appear in the columns "age" and "footlgth"

## 1.10
# (a)
1000*((1+0.075)^5 - 1)

# (b)
1000*((1+0.035)^5 - 1)

# (c)
1000*((1+0.075)^seq(1,10) - 1)
# the last line here returns a vector of numbers that correspond to the amount of interest earned in 1, 2, 3, ..., and 10 years, at 7.5% compounded interest

# clear the workspace of everything
rm(list=ls())

## 1.11
gender = factor( c( rep("female", 91), rep("male", 92) ) )
table(gender)
# makes a contingency table, with columns in the order given in the vector

gender = factor( gender, levels = c("male", "female") )
table(gender)
# makes a contingency table in the order given by levels argument

gender = factor( gender, levels = c("Male", "female") )
table(gender)
# note that mistake happens because case matters

table(gender, exclude = NULL)
# shows how many were excluded?

rm(gender)

## 1.13
par( mfrow=c(2,2) ) # 2 by 2 layout on the page
library( MASS ) # Animals is in the MASS package

plot( brain ~ body, data = Animals)

plot( sqrt( brain ) ~ sqrt( body ), data = Animals )

plot( I( brain^0.1 ) ~ I( body^0.1 ), data = Animals ) # I() forces its argument to be treated “as is”

plot( log( brain ) ~ log( body ), data = Animals )

par( mfrow=c(1,1) ) # Restore to 1 figure per page


## 1.16

# look at the structure of play data
str(socsupport)

# abbreviate genders to "f" for female and "m" for male by taking only the first letter of gender (do this for all rows)
gender1 = with( socsupport, expr = abbreviate(gender, 1))

# compare levels of new and old tables
table(gender1)

# abbreviate countries to only 3 letters
country3 = with( socsupport, expr = abbreviate(country, 3))

table(country3)

num = with(socsupport, expr = seq(along=gender))

lab = paste(gender1, country3, num, sep=":")

# make a box plot 
plot(formula =  BDI ~ age, data = socsupport)

# find the row numbers of the points that are outliers
with(socsupport, identify(x = age, y = BDI, labels = lab))
# (hit esc to exit identify and print row snumbers on plot and in command line)


## 1.19

head(vlt)

vltcbv = stack( vlt[, 1:3 ] )

table(vltcbv$values, vltcbv$ind)
table(vltcbv)

plot(table(vltcbv$values, vltcbv$ind)/nrow(vlt), main= "Contingency Table")


## 1.21
oldpar <- par( mfrow=c(2,4) )
for( i in 2:9 ){
  plot( austpop[,1], log( austpop[,i] ), xlab = "Year",
        ylab = names(austpop)[i], pch=16, ylim=c(0,10) )
}

pdf(file = "q1-21_eadie.pdf", useDingbats = FALSE, width=8, height=5)
par( mfrow=c(2,4))

sapply(X = 2:9, FUN = function(x)  plot(austpop$year, y = log(austpop[, x]), ylim=c(0,10), xlab = "Year", ylab=colnames(austpop)[x], pch=19 ) )

dev.off()
