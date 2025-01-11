# ----------------------------------------------------------------------------------------
# District Dynamics: Housing Market Analysis
# ----------------------------------------------------------------------------------------

# Author: Julian Griffin
# Purpose: Explore the relationship between song popularity and its characteristics
# Data Set: Provided by Kelly Ramsay

# ----------------------------------------------------------------------------------------
# 1. Data Wrangling & Preparation
# ----------------------------------------------------------------------------------------

# Important Note: Please set your own working directory as the one in the file is my own!

# Set working directory and load dataset
setwd("/Users/juliangriffin/Desktop/GitHub/R_Projects_Local/R_Projects/Project 2 - District Dynamics")
clean_data <- read.csv("clean_data.csv")

# Preview the first few rows of the data
head(clean_data)

## Filter the dataset with the following parameters:
# 1. Lot size greater than 0 sqft
# 2. Sale price greater than or equal to $10 000
# 3. Finished square feet greater than or equal to 500 units
clean_data_refit <- clean_data[clean_data$Lotsize > 0 & 
                                 clean_data$Sale_price >= 10000 & 
                                 clean_data$Fin_sqft >= 500, ]

# Log transformation to calculate price per square foot
clean_data_refit$ppsq <- log(clean_data_refit$Sale_price / clean_data_refit$Fin_sqft)

# ----------------------------------------------------------------------------------------
# 2. Model Construction
# ----------------------------------------------------------------------------------------

# Fit a multiple linear regression model
linear_model <- lm(ppsq ~ log(Lotsize) + Sale_date + Year_Built + District + Bdrms, data = clean_data_refit)

# Summarize the regression model
summary(linear_model)

# Check for Multicollinearity using Variance Inflation Factor (VIF)
if (!require(car)) install.packages("car")
library(car)
vif_values <- vif(linear_model)
print(vif_values)

## Key Insights:
# - The model explains ~21% of the variability in the price per square foot.
# - No covariates show signs of multicollinearity (as the VIF values <3)

# ----------------------------------------------------------------------------------------
# 3. Variable Selection
# ----------------------------------------------------------------------------------------

# Perform all-subsets regression using 'leaps' package
if (!require(leaps)) install.packages("leaps")
library(leaps)

# Convert District to factor variable
clean_data_refit$District <- as.factor(clean_data_refit$District)

# Perform exhaustive search for best subset
all <- leaps::regsubsets(ppsq ~ log(Lotsize) + Sale_date + Year_Built + District + Bdrms, 
                         data = clean_data_refit, nvmax = 50, method = 'exhaustive')

# Visualize adjusted R² values for different models
plot(all, scale = "adjr2")

## Plot Analysis:
# - LotSize, Sale_Date, Year_Built, District12, and District5 are key predictors contributing most to price prediction.
# - Adding more predictors beyond this model shows diminishing returns on adjusted R^2

# ----------------------------------------------------------------------------------------
# 4. Outlier & Influence Analysis
# ----------------------------------------------------------------------------------------

# Calculate leverage and influence measures
hat_values <- hatvalues(linear_model)
high_leverage <- mean(hat_values > (2 * length(coef(linear_model)) / nrow(clean_data_refit)))
cat("High-leverage observations:", high_leverage * 100, "%\n")

cooks_distance <- cooks.distance(linear_model)
influential_points <- mean(cooks_distance > 1)
cat("Proportion of influential points:", influential_points * 100, "%\n")

## Insights:
# - 2.4% of our data has high leverage (unusual prediction)
# - However, 0% of these points effect the regression fitting

# ----------------------------------------------------------------------------------------
# 5. Key Findings & Model Performance
# ----------------------------------------------------------------------------------------

## Key Insights:
# - The model explains ~21% of the variability in the output (price per square foot)
# - Significant variables: log(Lotsize), Sale_date, Year_Built, Bdrms.
# - No significant multicollinearity, all predictors are independent.
# - No signigicant outliers that effect our model.

# ----------------------------------------------------------------------------------------
# 6. Final Thoughts & Recommendations
# ----------------------------------------------------------------------------------------

# Conclusions:
# - The current model provides useful insights, though some predictors could be refined for better precision.
# - The model performs decently with room for further improvement.

# Recommendations:
# 1. Expand the District variable to capture more trends.
# 2. Check model assumptions to ensure regression robustness.
# 3. Explore advanced techniques (e.g., machine learning) to improve predictive accuracy.

