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

## 🔧 **Methodology**  

### **1. Data Preparation**  
📊 The dataset includes features such as:  
- `duration_ms`  
- `danceability`  
- `energy`  
- `acousticness`  
- `instrumentalness`  
- `liveness`  
- `tempo`  

💡 **Initial Exploration:**  
- Identified issues with **multicollinearity** and a high number of **zero-popularity** songs that skewed the data.

### **2. Model Development**  
- 🛠 **Initial Model:**  
  - Using all features resulted in a **low R² (~1%)**, indicating significant unexplained variability in predicting popularity.  
- 🔧 **Refinement:**  
  - Removed `acousticness` due to high **Variance Inflation Factor (VIF)**, addressing multicollinearity.  
- 🧹 **Filtered Model:**  
  - Excluded zero-popularity songs to improve **normality** and **homoscedasticity** in the residuals.

### **3. Assumption Checks**  
🔍 Residual analysis to assess:  
- 📈 **Normality**: Evaluated using a Q-Q plot and histogram of residuals.  
- 📉 **Homoscedasticity**: Assessed through a residuals vs. fitted values plot.  
- 📏 **Linearity**: Verified through visual inspection of scatter plots.  

✅ **Improvements:**  
- The filtering and refinement of the model corrected most assumption violations and led to a better-fitting model.

### **4. Outlier and Influence Analysis**  
- 🔺 **High-Leverage Points:**  
  - Approximately **7%** of observations were identified as high-leverage, but none of these observations excessively influenced the model (Cook’s distance < 1).  

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

