# Inference

* Interested in population quanties, represented by *parameters*, $\theta$.
* Collect sample X
* use a sample statistic $\hat{\theta}(X)$ to estimate (*infer*) a population quantity (statistic = function of data)
  * What are the properties of our estimator?
  * How close do we expect our estimator to be to the parameter?
* The sampling distribution f~x~ implies $f_{\hat{\theta}|\theta}$ ("distribution of $\hat{\theta}$ given $\theta$")
* We use $f_{\hat{\theta}|\theta}$ for inference about $\theta$
* We use $f_{\theta|\hat{\theta}}$ for inference about $\theta$ (Bayesian) (Note - what does $f_{\theta|\hat{\theta}}$ actually mean?)

# Point Estimate

Note: capital letter is "pre-sample", lower case is sample

* What is the population mean $\mu$?
  * A point estimate of $\mu$ is $\bar{x}$
* Look at the sampling distribution $f_{\hat{X}|\mu}$
  * $\sigma$ is the true stddev of the population
  * s is the estimate of sigma (calculated as $\sqrt{\Sigma\frac{(x_i - \bar{x})^2}{n-1}}$.)
* The sampling distribution of $t = \frac{\bar{x} - \mu}{SEM}$ is $f_{t|\mu}$.
  * t distribution comes from "integrating out $\sigma$" (look into this)

# Hypothesis Tests

Use $f_{\hat{\theta}|\theta}$ for inference about $\theta$.

* Assume $\theta = \theta_0$ (null hypothesis)
* What is the sampling distribution $f_{\hat{\theta}|\theta_0}$?
* If we sampled from $f_{\hat{\theta}|\theta_0}$, what values are likely/not likely? This defines rejection region.
* Now collect a sample and compute $\hat{\theta}_{obs}$
* Is $\hat{\theta}_{obs}$ in the rejection region? If so, reject initial hypothesis.

Hypothesis testing is a bit strange. Confidence interval seems a bit more useful.

# Confidence Intervals

* Consider $f_{\hat{\theta} - \theta}$, sampling distribution of difference between $\hat{\theta}$ and $\theta$.
* Given a probability, we can compute an interval for $\hat{\theta}$ - $\theta$ from $f_{\hat{\theta} - \theta}$.

# A short Comment

* Use hypothesis tests sparingly, and for good reason.
  * Multiple comparisons can result in false alarms
  * Ask directed questions
* Consider alternatives to hypothesis tests
  * They provide little to no info about $\theta$.
  * Confidence intervals provide much more info.
* Always report means (point estimates) and standard errors when reporting hypothesis tests. 

# Contingency Tables

Used to compare categorical variables.

> Are the variables independent or not?

Independence: Is the probability that you're in cell i,j equal to the probability that you're in column i * probability that you're in row j.

# One-Way Comparisons

Data: `tinting`

Experiment: time to discriminate a target for different window tinting levels.

## One-way ANOVA

ANalysis Of VAriance

Compare variance from full group versus variance due to differences in means of groups. 

1. Look at sum of squares in full samples vs within groups
2. Normalize by DOF, take ratio (= F)
3. Map F ratio to Pr(>F)

Pr(>F):

> If you repeat experiment 10 times, would only reject null hypothesis once.

If we start with hypothesis "there is no difference between different groups", then Pr(>F) is the probability that you would get F.

> Can think of ANOVA as a comparison of means between different groups.

## Two-Way Comparison

There are other factors that might influence comparison, e.g. age of participants.

Consider interaction plot - mean of each age group for each category.

Can look at the variance of interaction between variables - how much of the variance is due to the interaction between variables?

> If we split into 2 groups, is there more variance from one group to another than just by chance?

# Response Curves

Sometimes a response should be handled as a regression rather than ANOVA. Think about relationship between x1 and x2 in that one is a *function* of the other.

> How much of the variance is explained due to a response function rather than individually in each piece?

Paper: *Pseudoreplication And the Design of Ecological Field Experiments* - "famous" paper. If you have the same objects in different measurements for a study, "you don't have 15 measurements, you have closer to 3" (if 3 objects measured 5 different positions each).

## Nested Structures

6 tanks with 3 fish per tank. How many experimental units do we have for comparing treatment to control?

36? 18? More like 6 since there are 6 tanks.

> If the scale of your effect doesn't match the scale of your experimental unit, don't pretend that it does.

"scale" - difference between 2 "things" - tank-to-tank vs fish-to-fish vs blood sample to blood sample.

Nested structure -> blood belongs to a fish which belongs to a tank.

> 2 fish in the same tank are more likely to be similar than 2 fish in different tanks.

# Maximum Likelihood Estimation

* *Likelihood* is the probability of data X given a population parametrized by $\theta$.
* The value of $\theta$ that maximizes the likelihood is this *maximum likelihood estimate*, $\hat{\theta_{ML}}$.

IID - *Independent and Identically Distributed*

* Identically distributed - parameters are not indexed by i (same for every data point) - came from the same population. Same $\mu$ and $\sigma^2$.
* Independent - joint prob of 2 or more random variables is just product of individual probabilities.

L = .... -> likelihood (can get very small, too small to store in memory)

l = ... -> log likelihood

$$l = -\frac{1}{2}\log{(2\pi \sigma^2)} + \sum_{i=1}^n \frac{(y_i - \mu)^2}{2\sigma^2}$$

# Bayesian Estimation/Inference

> In Bayesian inference, start with prior probability/belief about which populations are more likely than others (indexed by theta) - which parameters of theta are more likely than others?
>
>
>
> We then update the those beliefs after observing X.

P(X) can be difficult to get, but is just a normalizing constant. So really we just need to get P(X|$\theta$)P($\theta$) - commonly use MCMC.





