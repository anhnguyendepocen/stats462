

# Regression Trees

Start with example of spam emails, classifying whether an email is spam or not.

## Decision Trees

Branch on decision making based on values of features. Note that height of arms is proportional to amount of total variance that a feature explains.

Very flexible tool...

* regression with continuous response
* binary response
* ordered outcomes
* unordered outcome
* survival analysis, etc.

Trees are best for large datasets with unknown structure.

* Make very weak assumptions
* Have (statistical) lower power to detect



Can use `rpart` in R to do *partition tree*. Table at bottom of slide 7 is cross validation error.

### Splitting Rules

Can split according to many different rules...

* Minimize Deviance (residual sum of squares)
  * Choose the split that results in the smallest possible deviance
* Minimize Gini Index
* Minimize information criteria

Often additional rules are imposed, like a minimum leaf group size

### Determining Tree Size

Each split usually improves performance. How to determine when to fit?

* Cross validation
* Complexity parameter trades off complexity with improved fit
  * Fit tree that is more complex than ideal
  * Prune tree back by setting complexity and minimizing CV cost
  * Rule of thumb: minimum error + 1 stddev

## Random Forest

* Large number of bootstrap samples are used to grow trees independently
* Grow each tree by:
  * Taking a bootstrap sample of the data
  * At each node, a subset of variables are selected at random. The best split on this subset is used to split the node.
  * There is no pruning. Trees are limited by a `minimum_size` at terminal nodes and/or maximum number of nodes.
* Out-of-bag  prediction for each observation is done by majority vote across trees that didn't include the sample (For any training example, it will have been used in some subset of trees that were created).
* Tuning parameter: number of variables that are randomly split out.

Random forests use full forest with majority vote for classification. Very little tuning. Accuracy usually much better. Only real downside is computation.