# Introduction to R

Some basic usage of R...

* Can use command line, rstudio, etc.
* `<-` used to assign values. `=` can also be used.
* `c()` function is "concatenate" -> make a list
* `data.frame()` -> create a "data frame" with columns, can have multiple data types. Note that `data.frame` is a class, not a method of a class or something. Bad naming convention.

Moving Around...

* `getwd()` - get working directory
* `setwd` - set working directory to the specified path
* When quitting R, can save workspace. This will save all your data , functions, etc.
* `ls` to see what's in your workspace, `dir` gives what's in your working directory.

Package Management

* `install.package()` to install packages. Packages have to pass a series of checks and tests, so most packages are good.
* Can get help with `?plot` or `help(plot)`
* Can search for functions with `apropos("sort")` or `help.search("sort")`
* `??keyword` - search functions for the keyword

Data Sources

* `help(read.table)`
* `fossilfuel <- read.table("fuel.txt", header = True)`
* `fossilfuel <- read.table("fuel.csv", header = True)`
* `data(package="datasets")`
* `save()`, `saveRDs()`,  `load()`, `loadRDs`
  * Save your workspace as a big "blob", get back your big workspace "blob"

R objects

* Numerical (`c(1,2,3,4,5)`)
* logical (`c(T,F,F,F,T)`)
* character (`c("red","blue")`)
* factor (`factor(c(1,3,4,5))`)

Comparing and extracting elements

```R
x <- c(-1, 4, 9, 0)
x > 0
x != 0
x == 0
?Comparison; ?Logic;
```



Generating pattern vectors

* `?seq`
* `4:10`
* `?rep`

Factors - can be tricky

```R
sex <- c(rep("female",4), rep("male",4))
levels(sex) #NULL
sex <- factor(sex)
levels(gender) # "female", "male"
str(gender)
sex <- factor(gender, levels = c("male","female"))
levels(sex) # "male", "female"
```

Data Frames and Matrices

* `data.frame` is list of vectors with same length
* Columns can be different types. Can check column types with `class()`
* `matrix` is 2d vector, all entries have same type
* Can use `[]` for indexing data frames
  * `my.df[rows.vector, cols.vector]`
* Can use `$` for indexing lists, and therefore dataframes
  * `my.df$name.of.column`
* Can also use `subset()`
  * `subset(my.df, subset = rows.logical, select = cols.expression)`

Can shorten calls using `with()`

* `with(my.df, plot(x, y, pch=(19:21)[group]))`
* Can also use `attach`, but don't. Creates confusing scopes.

Aggregation, Stacking, Unstacking

* `aggregate(my.df, by = my.df$group, FUN = var)`
  * Split dataframe by group, computing some summary stat, return result per group
* `stack(my.df, select 1:2)`
  * Concatenate multiple vectors into single vector
* `unstack(my.df, form = x ~ group)`

Random others

* Can print something by wrapping in `()`, e.g. `(x <- 3)`
* `table(Sex=tinting$sex, AgeGroup=tinting$agegp)`
  * Counts of each bin
* `sapply`

**Aaron's Quiz 1 solution**

```R
insects <- read.csv("insects.csv",header=TRUE,row.names=1)
insects <- stack(insects)
names(insects) <- c("number","treatment")
plot(number~treatment, data=insects)
```

Note that `plot` or `boxplot` (as gwen used) plots things as categorical data.

Generic Functions and Classes

* Generic functions do different things based on the class passed in
* `print.factor()`, `print.data.frame(), etc.`
* `plot.formula()`, `plot.ts()`
* Note that there are 3 different ways to create classes with varying strictness. This defines how the above functions interact.

Can write your own functions in R.

```R
meanQuants <- function(x, p = c(0.05,0.95), ...){
   mu <- mean(x)
   quants <- quantile(x, probs = p, ...)
   c(mu, quants)
}
```

Last line will be return value. Can also use `return()`. Note that it's faster _not_ to use `return`. Note also that `...` above is **real syntax**. It groups whatever you pass in there and passes it to other functions that accept `...`.

R has flow control...

*  `?Control`
* if, for, while, repeat, ...

Graphics

* `demo(graphics)`
* `?par` to make columns, rows of plots (`par` = "parameters")
* can save `par` settings for later use.

Note - R will try to follow an aspect ratio that puts the data close to 45^o^ patterns, since this is the easiest pattern for humans to interpret.

Another neat bonus - R has an interactive front end. You can use `locator()` and `identify()`, for example, to _label the points on a graph when you click them._ - this is very cool!

Can also use other packages to plot...

* `library(ggplot)`
* `library(lattice)`
  * e.g. `xyplot(ht ~ wt | sport)` - "plot height as a function of weight for a given sport"
  * Bad help, not easy to customize



For next time - Work on lab 1, assignment 1.







