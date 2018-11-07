library(DAAG)

# 4.1

#     The ‘nswdemo’ data frame contains 722 rows and 10 columns. These
#     data are pertinent to an investigation of the way that earnings
#     changed, between 1974-1975 and 1978, for an experimental treatment
#     who were given job training as compared with a control group who
#     did not receive such training.
#
#     trt a numeric vector identifying the study in which the subjects
#          were enrolled (0 = Control, 1 = treated).
#     age age (in years).
#     educ years of education.
#     black (0 = not black, 1 = black).
#     hisp (0 = not hispanic, 1 = hispanic).
#     marr (0 = not married, 1 = married).
#     nodeg (0 = completed high school, 1 = dropout).
#     re74 real earnings in 1974.
#     re75 real earnings in 1975.
#     re78 real earnings in 1978.

# 4.1a
# Use t test to get confidence interval for re75 as a function of trt
ci = with(nswdemo, t.test(re75~trt))
print("Confidence interval for real earnings in 1975 as a function of group:")
print(ci)

#4.1b

ci = with(nswdemo, t.test(re78~trt))
print("Confidence interval for real earnings in 1978 as a function of group:")
print(ci)

#4.1c
nswdemo$diff = nswdemo$re78 - nswdemo$re75
control = subset(nswdemo, trt==0)
helped = subset(nswdemo, trt==1)

ci = with(control, t.test(diff, paired=TRUE))
print("Confidence interval for difference in real earnings between 1978 and 1975 for control group:")
print(ci)

ci = with(helped, t.test(diff~trt))
print("Confidence interval for difference in real earnings between 1978 and 1975 for trained group:")
print(ci)

#4.8
# names: > [1] "trt"   "age"   "educ"  "black" "hisp"  "marr"  "nodeg" "re74"  "re75" "re78" 
#with(psid3, plot(age))
#plot(x,y1,type="l",col="red")
#lines(x,y2,col="green")

#4.9
#
# In order to test whether these results are different from the "expected", we can perform a chi-squared test (or a Fisher's Exact Test if n is small enough) to check how much our results vary from just distributing the counts according to row/column probabilities. e.g. P(i,j) (probability of being in cell i,j) = P(i) * P(j) (probability of column i times probability of row j). That is, do the distributions in each row/column match what you'd expect for summing rows and columns?

acup = matrix( c(74, 71, 43, 38, 11, 65), ncol=3, dimnames=list(c("LargeReduction", "SmallReduction"), c("Acupuncture", "Sham", "WaitingList")))
result = chisq.test(acup)
print(result)

# This gives us a result of p = 9e-8
# This implies that these items are likely *not independent*
# We can say something along the lines of "There isn't no relationship between these treatments."

