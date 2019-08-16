library(randomForest)
library(DAAG)

### example from lecture on regression trees

?spam7

sherwood = randomForest(yesno ~ ., data=spam7, importance = TRUE)

plot(sherwood)

summary(sherwood)


###

## 11.3
# Use tree-based regression to predict re78 in the data fram nswpsid1
library(rpart)

str(nswpsid1)

# compare the predictions with the multiple regression predictions in Ch 6

?rpart


Boreal <- rpart(re78 ~ trt + age + educ + black + hisp + marr + nodeg , data = nswpsid1, control = list(cp=0.001))

printcp(Boreal)

#CP nsplit rel error  xerror     xstd
# 7  0.0052595      6   0.76066 0.77446 0.038514

re78predict = lm(formula = re78 ~ trt + age + educ + black + hisp + marr + nodeg , data = nswpsid1)


## 11.4 

spam = read.csv("spambase.data", header=FALSE)

saguaro = rpart(V58 ~ ., data = spam, cp=0.001)


