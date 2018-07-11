# Styles of Data Analysis

First rule of data analysis - **PLOT YOUR DATA**

## Exploratory Data Analysis (EDA)

> Let the data speak for itself

* Suggest new ideas/understandings
* Reveal bad assumptions
* Check assumptions in subsequent analysis
* Suggest future research

Potential cons:

* Looking at early data could lead you to chase patterns that don't exist

## Plotting Single Variables

Histograms...

* Depends on bin choice
* Does **not** let data speak for itself

Box plot

* Whiskers extend to furthest data point that isn't 2.5 times further than inter-quartile range (the box).

* Points outside whiskers plotted by themselves. Often, this is an indication that those points are _outliers_.

* > They're ok. They're not bad. -Aaron

* Not good at showing distributions with multiple peaks.

* _Violin Plots_ do a better job at showing these distributions

## Plotting Bivariate Data

Example: people rating sweeteners in milk...

* _Rug plot_ (draws ticks on x/y axis where points are)
* Positive relationship between variables

Example: resistance vs juice (?!)

* _LOESS/LOWESS_ estimator: not imposing any specific function
* Much better than assuming a relationship
* Helps guide the eye as to what the relationship _might_ actually be.

Example: brain mass vs body mass

* Linear scaling isn't always ideal
* Can transform the data, e.g. log-log

## Clustering

Example: Height of New York Choral Society...

* Plot density of points, may give an idea of distributions

## Outliers

* Require special treatment
* Can be highly influential in modeling
* Can suggest new understanding

## Multidimensional Data

* _Conditioning Plots_
  * Break the data into chunks according to variable 3, then plot variable 1 vs variable 2.
* _Scatterplot Matrix_
  * Every combination of X~i~ vs X~j~
* _Sparkline Plots_
  * Essentially just plot each variable without explicitly showing the range
  * Meant to show the general relationships

## Summary Statistics

Example: Survival on the Titanic. _Contingency Plots_

* Central Tendancy
  * Mean, median, mode
* Dispersion
  * Standard deviation, IQR (nter-quartile range), range
* Counts by group or category

## Moving On After EDA?

* Science
  * Test hypothesis
  * Mechanism important
* Prediction Goal
  * Prediction performance most important, not mechanism

## Observational vs. Experimental Data

* Experimental data gold standard
  * Randomization allows isolation of effects
  * Caution about generalization
* Observations abundant
  * Experiments are not always possible
  * Features/relationships difficult/impossible to isolate

## Data from Surveys

Are we measuring what we think we're measuring?

## Planning Ahead

* Plan data analysi **before** it's collected (if possible) - could use data from another study to guide
* Often doing analysis _after_
  * Avoid _fishing expedition_ - ask directed questions to the data (don't just change questions to get the answer you want).
  * Sometimes not possible to answer certain question



