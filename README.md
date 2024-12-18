# 🎵 Spotify Symphony: A Linear Regression Approach on Spotify Data

## Author: **Julian Griffin**

### 🚀 **Overview**  
So, here's the deal: I was given a dataset of Spotify songs, and instead of just running some basic analysis, I decided to turn it into my own little musical adventure. The question I started with? What actually makes a song popular on Spotify? Because, let’s be real—there are songs out there that get way too many streams (you know the ones), and then there are songs that deserve the spotlight but are stuck with zero plays. What's the deal with that?

At first, I thought I’d just plug in some numbers and call it a day. But then I realized I was diving into a world where songs have hidden personalities—danceability, energy, tempo… all that good stuff. I wanted to know if these features could actually predict a song’s popularity. I mean, if I can figure out the secret sauce behind a viral hit, I’ll be ready for the next big music trend, right?

As I worked through the math, I started realizing that some of the things we think makes a "good" song might not be what makes it popular. Through Formidable Formulas, Nebulous Numbers, and Enigmatic Equations I embarked on an enjoyable journey into understanding what makes songs tick—and maybe, just maybe, uncovering some of the magic behind the Spotify algorithm.

---

## 🎯 **Objectives**  
1. 🕵️‍♂️ Understand the factors influencing **song popularity**.  
2. 🔍 Identify **significant predictors** of popularity using linear regression.  
3. 🔄 Address **multicollinearity** and refine the model for better accuracy.  
4. ✅ Ensure **model assumptions** (normality, homoscedasticity, linearity) are met.  

---

## 🔧 **Methodology** (Parts 1-6) 

### **1. Data Preparation**  

📊 **Covariates Featured**:  
- `duration_ms`, `danceability`, `energy`, `acousticness`, `instrumentalness`, `liveness`, `tempo`  

💡 **Initial Steps**:  
- The first step was to **import** the data and ensure everything was loading into R properly. We set the working directory and loaded the dataset using `read.csv()`. Afterward, we previewed the data with the `head()` function to get a glimpse of the first few rows and check the structure.

Example of code used:
```R
setwd("/Users/juliangriffin/Desktop/R_Projects_Local/R_Projects")
spotify <- read.csv("spotify_data.csv")
head(spotify)
```

---

### **2. Model Development**

🔨 **2.1: Initial Model Fit**  
- Created a **full regression model** with all features.

![Insert summer output image here](path_to_your_image) 

💡 **Key Findings**:  
- **Model Fit**: The R² value was low (~1%), meaning there’s a large amount of unexplained variability in popularity.  
- **Significant Predictors**: 
  - **Danceability** positively impacts popularity.
  - **Energy**, **acousticness**, and **instrumentalness** have a **negative effect** on popularity.
- **Non-significant Predictors**: 
  - `duration_ms` and `liveness` were not found to be significant predictors.

<br>
<br>

🔄 **2.2: Multicollinearity Check**  
We used the **Variance Inflation Factor (VIF)** to check for multicollinearity in our predictors. High VIF values suggest some predictors are highly correlated with others, potentially distorting the model.  

💡 **Key Findings**:  
- **Acousticness** and **energy** exhibited **high VIF values**, indicating potential multicollinearity between the variables.
- **Next Steps**: We decided to remove **acousticness** from the model to reduce multicollinearity and improve model stability.

Example of code used to check VIF:
```R
# Load the 'car' package for VIF calculation
library(car)

# Check for multicollinearity using VIF
vif_values <- vif(model_full)
print(vif_values)
```
<br>
<br>

🔧 **2.3: Refitting the Model**  
After addressing multicollinearity, we refitted the model by **excluding acousticness** from the predictors. This better improved the model’s stability like hypothesized.  

💡 **Key Findings**:  
- **Refined Model**: Removing **acousticness** lowered VIF values and improved the model's stability.
- **Energy** now showed a stronger effect on popularity without the interference from **acousticness**. 

---

### **3. Assumption Checks**  

🔍 Moving on, we analyzed the residuals to ensure the model adhered to assumptions:  
- **Normality**: Evaluated with Q-Q plots and histograms.  
- **Homoscedasticity**: Assessed with residuals vs. fitted plots.  
- **Linearity**: Verified visually through scatter plots.

Example of code used for plot analysis:
```R
# Q-Q plot for residuals to check normality
qqnorm(residuals(model_refit))
qqline(residuals(model_refit), col = "red")

# Histogram of residuals
hist(residuals(model_refit), col = "green", main = "Histogram of Residuals", xlab = "Residuals")

# Residuals vs Fitted plot to check homoscedasticity and linearity
plot(fitted(model_refit), rstudent(model_refit), 
     main = "Residuals vs Fitted Values", xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col = "red")
```
<br>

![Insert residual analysis output image here](path_to_your_image)  
![Insert residual analysis output image here](path_to_your_image) 

<br>

💡 **Key Findings**:  
- **Normality Violation**: Residuals were skewed, suggesting a violation of the normality assumption.  
- **Heteroscedasticity**: The funnel shape in the residuals vs. fitted plot suggested heteroscedasticity.  
- **Linearity**: No major issues were detected in the linearity assumption, but further refinement was necessary for normality and homoscedasticity.

✅ Next Steps: To filter the data to correct the assumption errors

---

### **4. Model Refinement**  
🔧 Built a reduced model excluding weaker predictors (e.g., `liveness` and `duration_ms`), resulting in:  
- Improved homoscedasticity and residual distribution.  
- Enhanced interpretability with fewer variables while maintaining significance.  

---

### **5. Outliers and Influence Analysis**  
- 🔺 **High-Leverage Points**:  
  - Around **7%** of observations were high-leverage but did not overly influence the model (Cook’s distance < 1).  
- 🔍 **Impact on Results**:  
  - Adjusted the model to limit outlier effects, further stabilizing predictions.  

---

### **6. Results**  
**Key Insights**:  
- ✅ `Danceability`: Positive impact on popularity.  
- ❌ `Energy`, `acousticness`, `instrumentalness`: Negative impacts on popularity.  
- Refined model assumptions improved, but most variability remains unexplained.  

**Model Takeaways**:  
- Refinement reduced multicollinearity and improved residual behaviour.  
- Explained only a small fraction of the variability in song popularity, suggesting additional factors are at play.  

---

## 📊 **Results**  

- **Significant Predictors:**  
  - ✅ `Danceability` has a **positive impact** on song popularity.  
  - ❌ `Energy`, `acousticness`, and `instrumentalness` show a **negative impact** on popularity.  
- **Refined Model Performance:**  
  - The refined model showed improvements in model assumptions with a better distribution of residuals and reduced multicollinearity.

---

## 🏁 **Conclusion**  
✨ The refined model explains song popularity trends better, but **most of the variability remains unexplained**, suggesting there are additional, unexplored factors affecting popularity.

---

## 🔮 **Recommendations**  

1. **Include More Covariates** 📂  
   - Add features such as **song genre**, **release year**, and **artist popularity** for more comprehensive predictions.  

2. **Add Interaction Terms** 🔗  
   - Explore how variables like `danceability` and `energy` interact and contribute to song popularity when combined.

3. **Try Advanced Models** 🤖  
   - Experiment with **machine learning** models such as decision trees, random forests, or neural networks to uncover deeper patterns and improve predictions.

---

## 🛠 **Skills and Tools**  
- **Programming Language:** R  
- **Libraries:** `ggplot2`, `dplyr`, `lm`, `car`, `ggfortify`, etc.  
- **Skills Demonstrated:** Data wrangling, linear regression analysis, model diagnostics, hypothesis testing, residual analysis.

---

## ⚙️ **Future Work**  
- **Cross-validation:** To ensure the model generalizes well to new data.  
- **Hyperparameter tuning:** Use techniques like grid search or random search to fine-tune the model parameters for optimal performance.  
- **Time-series analysis:** If predicting song popularity over time, consider time-series models to account for trends and seasonality.

