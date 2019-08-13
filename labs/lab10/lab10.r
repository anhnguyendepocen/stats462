### 1. Which are random vs. fixed effects

# Fixed effects: school, sex, minority (or not)

# Random effects: SES, score, SESschool

### 2. What is a situation in which we would treat School as a fixed effect?

# If we care about particular schools

# when we don't need to generalize to other schools that aren't in the data set

### 3. What is a situation in which we would treat School as a random effect?

# when you want to generalize to schools that are not in the data set
# e.g. we want to predict test score, and there are different sources of variation, some of which might be school driven. 

# when you want to account for a school as a source of variation.

### 4. Write down the model that has Score as the response and includes all covariates except SESschool. Treat School as a random effect.

# score = school + (minority + sex + SES) + random(error)

# school = random(school error)

### 5. Analyze these data using the model you specified in (4.).
library(lme4)

out = lmer(Score ~ (1|School) + SES + Sex + Minority, data=reading)

summary(out)

# Are there statistically significant effects of Minority, Sex, and SES? 
# Looking at the fixed effects table, the estimates are all well above or below 0, and far beyond 2 standard errors from zero.


# Compute an estimate of the proportion of variation attributable to differences between schools given the covariates.

# school/(school + residuals) is about 3.6/40 which is about 10%


### 6. Write down the model that has Score as the response and includes all covariates except SESschool. Include separate intercepts and slopes for each school, treating the schools as fixed effects.
# and
### 7. Analyze these data using the model you specified in (6.). 
  
out2 = lm(Score ~ School + SES:School + Sex + Minority, data=reading)

summary(out2)

nrow(summary(out2)$coefficients)
#[1] 322   <== because there are 160 schools, so there are 160 intercepts, and 160 slopes, then the other two are the SexM intercept and Minority intercept


# Predict the expected Score for a female student with Minority status and SES = 1 by averaging across schools. For which schools does this prediction apply?

pred_df <- data.frame( School = unique(reading$School),
                       Minority = "Yes",
                       Sex = "F",
                       SES = 1 )

rowspredicted = predict( out2, newdata = pred_df)

mean(rowspredicted)

sd(rowspredicted)

summary(rowspredicted)

### 8. Write down the model that has Score as the response and includes all covariates except SESschool. Include random intercepts and slopes for each school.
# and
### 9. Analyze these data using the model you specified in (8.).
  
out3 = lmer(Score ~ ( SES | School ) + Sex + Minority, data=reading)
     
     # +1 ro make an intercept explicit, -1 to remove the intercept
     
summary(out3)     
     
# Are there statistically significant effects of Minority, Sex, and SES?
# Yes, for the same reasons we argued above.

# Predict the expected Score for a female student with Minority status and SES = 1. For which school does this prediction apply?
     
rowspredicted = predict( out3, newdata = pred_df)

mean(rowspredicted)

sd(rowspredicted)

summary(rowspredicted)
