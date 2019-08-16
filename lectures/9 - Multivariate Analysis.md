# Multivariate Analysis

Motivating problem: measure a bunch of information about possums. Visualizing more than a few variables is very difficult.

## Principal Component Analysis (PCA)

Creates new variables using linear combinations of existing variables.

* First component chosen to explain as much of the variation as possible
* Subsequent components chosen in the same way.
* Components are orthogonal

Then look at importance of components (importance ~ length of component ), proportion of total variance explained by component, and cumulative proportion.

Then look at the _loadings_ (coefficients of linear transformation from original dimensions). The loadings might help you interpret what the new components _represent_.

Can then look at plots of PC1 vs PC2, etc.

When to use?

* Description of patterns in higher dimensional data
  * Direct interpretation of components
  * graphical display using components
  * grouping/clustering
* Transformation for subsequent statistical analysis
  * Use components as explanatory variables in regressions
  * Avoid problems with multicollinearity
  * Use first component as response variable in regression

## Multidimensional Scaling

* PCA is a more specific version of a more general class called Multi Dimensional Scaling (MDS).
* In MDS, we take multivariate data and display them in fewer dimensions, doing our best to maintain the distance between points
* Classical MDS with Euclidean distance is equivalent to PCA

### Distance Metrics

* Euclidean distance
* Manhattan distance:
  * sum of absolute value of differences
* Canberra distance
  * manhattan distances with each sum element normalized by sum

### Ordination Metrics

* Classical MDS
  * distances treated as euclidean
  * Find lower dimensional representation that best preserves distances
* Sammon Method
  * Minimize weighted sum of squared distances between dissimilarities and representation distances
  * Weights are proportional to dissimilarities
* Kruskal's non-metric MDS
  * Dissimilarities are allowed a monotonic transformation
    * Only ranks of dissimilarities matter
  * Minimize _Stress_

