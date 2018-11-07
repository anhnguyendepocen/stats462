# A Review of Inference Concepts

**Terminology**

* *Random Sample* - a set of values drawn independently from a larger population
  * *Uniform Random Sample* - All members of the population have an equal chance of being drawn.
* *Parameters* - values that numerically summarize various aspects of a population
* *Statistics* - estimated of parmeters obtained by sampling the population
* *Standard Error of the Mean (SEM)* - standard deviation of sampling distribution of the mean. Represents accuracy of sample mean as an estimate of the population mean.
* *Sampling Distribution of the t-statistic* - number of std err units between true value $\mu$ and sample estimate $\bar{x}$.
* *p-value* - the significance level that rejects a hypothesis (i.e. creates a confidence interval that *just* doesn't include the value you're testing.)
* *Hypothesis Testing*
  * *Null Hypothesis* - does $\mu$ = 0?
  * *Alternative Hypothesis* - does $\mu \neq$ 0?

## Basic Concepts of Estimation

Parameters are usally estimated using statistics calculated using a random sample from the population. *Sample mean* is an example of a statistic (*population parameter* is the true value, statistic is the estimate). Other common stats:

* Proportion
* Standard Deviation
* Variance
* Median
* quartiles
* Slope of regression line
* correlation coefficient

Previously: learned about the *sampling distribution of the mean* (distribution of means with repeated random sampling). Standard deviation of this distribution is known as *Standard Error of the Mean (SEM)*.

> As a consequence of the Central Limit Theorem (CLT), the sampling distribution of the mean can, for a population with mean $\mu$ and standard deviation $\sigma$, often be well approximated by a normal distribution with mean $\mu$ and stddev $\frac{\sigma}{\sqrt{n}}$. 

Note from Aaron:

> The difference in wording here is just distinguishing between infinite samples and finite samples (in the limit of infinite, the sample of means would be exactly normal\*\*). As the book notes, there is a lot "behind the scenes" of this. For example, is the population infinite? If not, what does it mean once you've fully sampled it?

This means $SEM = \frac{s}{\sqrt{n}}$, where s is an estimator of the population standard deviation $\sigma$ (Note this is discussed in section 3.3.3). This requires data to be IID. Small SEM implies sample mean is close to population mean.

* If looking at difference of means, the standard error is $\sqrt{SEM_1^2 - SEM_2^2}$.
* Std error of median: $SE_{median} = \sqrt{\frac{\pi}{2}}\frac{s}{\sqrt{n}}$, or about 25% greater than SEM (implication: for data from a normal distribution, mean can be estimated more easily than median).
* For non-normal distributions, can use *The Sampling Distribution of the t-statistic*: $t = \frac{\bar{x} - \mu}{SEM}$.

I'm confused about this:

> The replacing of $\sigma$ by s introduces an uncertainty that is larger as the degrees of freedom n-1 in s are smaller. Hence the use of a t-distribution with n-1 deg. of freedom, where if $\sigma$ was known predicely a normal distribution would be used.

## Confidence Intervals and Tests of Hypotheses

* Given distance from the mean, calculate area under the curve.
  * Use function with `p` in front, such as `pnorm` or `pt`.
* Given an area under the curve, calculate the limit or limits.
  * Use functions with `q` in front such a `qnorm` or `qt`

Don't understand bottom of pg 106:

> The second of these statements makes it possible to say that in sampling from the sampling distribution of $t_8 = \frac{\bar{d} - \mu}{s/\sqrt{9}}$, 95% of the values of t~8~ will lie between -2.31 and 2.31, i.e. $\bar{d} - \mu$ will ie between -2.31s and 2.31s. In other words, 95% of suchs samples $\bar{d}$  will lie within a distance of 2.31s of $\mu$.

This gives us the following *confidence intervals* (CI):

* 95% CI: 6.33 - 2.03\*2.31, 6.33+2.03\*2.31 = (1.64, 11.02)
* 99% CI: 6.33 - 2.03\*3.36, 6.33+2.03\*3.36 = (-0.49, 13.15)

In the above cases, we can reject the hypothesis that the population mean includes 0 to 5% *significance level,* but can't reject the hypothesis to 1% sig. level (the 99% CI includes 0). The *p value* is the significance level that *just* rejects hypothesis. This can be obtained by doubling the prob that the t-statistic is less than $-\frac{mean}{SEM}$.

Formal hypothesis testing: Test $\mu$ = 0 (*null* hypothesis), and $\mu \neq$ 0 (*alternative* hypothesis). The hypothesis that $\mu$ = 0 is a "straw man" because it's easy to knock down. But, this means formal hypothesis testing has a lot of pitfalls.

When is pairing helpful?

* If val 1 vs val 2 (the two items that get paired) is correlated, then the SED will be lower than the root mean square of the 2 separate errors.
* If they are not, then SED isn't much different from RMS of 2 separate errors.

> If the data are paired, then the 2-sample t-test corresponds to the wrong model

Why?

What if the standard deviations are unequal?

* t-stat based on pooled variance is inapp.
* *Welch statistic* - unequal variances, need degrees of freedom reasonably large.

$$t = \frac{\bar{x_2} - \bar{x_1}}{SED}$$,

$$SED = \sqrt{\frac{s_2^2}{n_2} + \frac{s_1^2}{n_1}}$$,



