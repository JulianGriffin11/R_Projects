# ----------------------------------------------------------------------------------------
# Spotify Song Popularity Analysis: Linear Regression
# ----------------------------------------------------------------------------------------

# Author: Julian Griffin
# Purpose: Explore the relationship between song popularity and its characteristics
# Data Set: Provided by Kelly Ramsay

# Important Note: Please set your own working directory as the one in the file is my own!

# ----------------------------------------------------------------------------------------
# 1. Data Preparation
# ----------------------------------------------------------------------------------------

# Please set your own working directory as the following is my own!

# Set working directory and assign name to data set
setwd("/Users/juliangriffin/Desktop/R_Projects_Local/R_Projects/Project 1 - Spotify Symphony")
spotify <- read.csv("spotify_data.csv")

# Preview data to see if everything loaded properly
head(spotify)

# ----------------------------------------------------------------------------------------
# 2. Model Development
# ----------------------------------------------------------------------------------------

## 2.1 Initial Model Fit
# Fit a multiple linear regression model with all predictors
model_full <- lm(popularity ~ duration_ms + danceability + energy + acousticness + instrumentalness + liveness + tempo, data = spotify)

# Summarize the results of the model
summary(model_full)

### Key Findings:
# - Model Fit: Low R^2 (~1%) indicates large amount of unexplained variability in popularity.
# - Significant Predictors: Danceability positively impacts popularity while energy, acousticness, and instrumentalness have negative effects.
# - Non-significant Predictors: Duration_ms and liveness.


## 2.2 Multicollinearity Check
# Install the 'car' package if not already installed
if (!require(car)) install.packages("car")
library(car)

# Check for multicollinearity using Variance Inflation Factor (VIF)
vif_values <- vif(model_full)
print(vif_values)

### Key Findings:
# - High VIF values for acousticness and energy suggests collinearity between covariates.
# - Next step: Remove acousticness to refine the model and confirm the hypothesis


## 2.3 Refitting Model
# Fit a reduced model excluding acousticness
model_refit <- lm(popularity ~ duration_ms + danceability + energy + instrumentalness + liveness + tempo, data = spotify)
summary(model_refit)
vif(model_refit)

### Key Findings:
# - Lowered VIF values confirm our hypothesis and reduced multicollinearity.
# - Coefficient changes highlight energy's stronger effect without acousticness.

# ----------------------------------------------------------------------------------------
# 3. Check Assumptions
# ----------------------------------------------------------------------------------------

## 3.1 Residual Analysis
# Check assumptions: normality, homoscedasticity, linearity

# Q-Q Plot for residuals
qqnorm(residuals(model_refit))
qqline(residuals(model_refit), col = "red")

# Histogram of residuals
hist(residuals(model_refit), col = "green", main = "Histogram of Residuals", xlab = "Residuals")

# Residuals vs Fitted Values
plot(fitted(model_refit), rstudent(model_refit), 
     main = "Residuals vs Fitted Values", xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col = "red")

### Key Findings:
# - Residuals are skewed suggesting normality assumption violated.
# - Funnel shape in residuals vs. fitted plot suggests heteroscedasticity.
# - We notice a large amount of data at x = -30, indicating the need for further exploration

# ----------------------------------------------------------------------------------------
# 4. Model Refinement
# ----------------------------------------------------------------------------------------

## 4.1 Exploration of Histogram Discrepancy
# Create a histogram of the popularity scores
hist(spotify$popularity, 
     col = "blue", 
     main = "Histogram of Popularity Scores", 
     xlab = "Popularity", 
     breaks = 30)

## Results: we notice an unusually large amount of data at x=0. Likely a problem when the popularity scores are 0.

# Towards fixing the problem, filter the data for non-zero popularity scores
spotify_filtered <- subset(spotify, popularity > 0)

# Refit model on filtered data (no zero popularity songs)
model_filtered <- lm(popularity ~ duration_ms + danceability + energy + instrumentalness + liveness + tempo, data = spotify_filtered)
summary(model_filtered)


## 4.2 Address Homoscedasticity
# Our next step is to check each covariate's residual errors to visual see which are problematic for our assumptions

# Install and load necessary libraries
if (!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

# Create a new data frame for studentized residuals and fitted values
spotify_filtered$residuals <- rstudent(model_filtered)
spotify_filtered$fitted <- fitted(model_filtered)

# List of covariates
covariates <- c("duration_ms", "danceability", "energy", "instrumentalness", "liveness", "tempo")

# Plot studentized residuals against each covariate
for (covariate in covariates) {
  plot(spotify_filtered[[covariate]], spotify_filtered$residuals,
       xlab = covariate,
       ylab = "Studentized Residuals",
       main = paste("Studentized Residuals vs.", covariate))
  abline(h = 0, col = "red") 
}

## Results: The covariates liveness, instrumentalness, and duration_ms show noticeable patterns in their residual plots.
# This indicates these variables are affecting our assumptions negatively


## 4.3 Re-check Assumptions
# Exclude liveness, instrumentalness, and duration_ms for improved homoscedasticity
model_reduced <- lm(popularity ~ danceability + energy + tempo, data = spotify_filtered)

# Q-Q Plot for residuals
qqnorm(residuals(model_reduced))
qqline(residuals(model_reduced), col = "red")

# Histogram of residuals
hist(residuals(model_reduced), col = "green", main = "Histogram of Residuals", xlab = "Residuals")

# Residuals vs Fitted Values
plot(fitted(model_reduced), rstudent(model_reduced), 
     main = "Residuals vs Fitted Values", xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col = "red")

### Key Findings:
# - Homoscedasticity assumption corrected with reduced funnel effect by reducing covariates
# - The removal of zero popularity values significantly improved the normality assumption, making the distribution more normal
# - The residuals appear evenly distributed around zero, which supports the linearity assumption.

# ----------------------------------------------------------------------------------------
# 5. Outliers and Influence Analysis
# ----------------------------------------------------------------------------------------

## 5.1 Leverage Points
hat_values <- hatvalues(model_reduced)
high_leverage <- mean(hat_values > (2 * length(coef(model_reduced)) / nrow(spotify_filtered)))
cat("High-leverage observations:", high_leverage * 100, "%\n")


## 5.2 Influence Points
cooks_distance <- cooks.distance(model_reduced)
influential_points <- mean(cooks_distance > 1)
cat("Proportion of influential points:", influential_points * 100, "%\n")

### Key Findings:
# - High-leverage points present (~7%), but none excessively influence the model (Cook's distance < 1).
# - This means no single observation is disproportionately affecting the model's coefficients

# ----------------------------------------------------------------------------------------
# 6. Results
# ----------------------------------------------------------------------------------------
# 
# - Please refer to the README file!
#
# ----------------------------------------------------------------------------------------
# 7. Conclusion and Recommendations
# ----------------------------------------------------------------------------------------

## Conclusion
# - Initial models explained only a small fraction of variability in popularity (~1%) and the reduced (~0.5%)
# - Danceability positively impacts popularity, while energy, acousticness, and instrumentalness negatively affect it.
# - Multicollinearity and assumption violations were addressed, leading to a more stable model.
# - The model's assumption violations were addressed by excluding songs with zero popularity and by refining the predictor set. 
# - Only around 7% of observations exhibited high leverage, but no single observation excessively distorted the results.
#
#   Overall, while the refined model better fit the data, it still leaves significant variability in popularity unexplained. 

## Recommendations
#   1. Include More Covariates: 
#     - Incorporate details like song genre, release year, and artist popularity to capture additional factors influencing popularity.
#   2. Add Interaction Terms
#     - Explore how factors like danceability and energy interact, revealing combined effects on popularity.
#   3. Try Different Models: 
#     - Experiment with advanced methods like neural networks for tackling the complexity of predicting song popularity 
# ----------------------------------------------------------------------------------------
