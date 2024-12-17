# 🎵 Spotify Song Popularity Analysis: Linear Regression 🎶  

## Author: **Julian Griffin**  

### 🚀 **Overview**  
This project explores the relationship between **song popularity** and various audio characteristics using a dataset provided by Kelly Ramsay. The analysis uses **multiple linear regression** to identify significant predictors of popularity and assesses assumptions for model validity.  

---

## 🎯 **Objectives**  
1. 🕵️‍♂️ Understand the factors influencing **song popularity**.  
2. 🔍 Identify **significant predictors** using linear regression.  
3. 🔄 Address multicollinearity and refine the model.  
4. ✅ Ensure **model assumptions** (normality, homoscedasticity, linearity) are met.  

---

## 🔧 **Methodology**  

### **1. Data Preparation**  
📊 The dataset includes song characteristics like:  
- `duration_ms`  
- `danceability`  
- `energy`  
- `acousticness`  
- `instrumentalness`  
- `liveness`  
- `tempo`  

💡 **Initial Exploration:** Found issues with multicollinearity and a large number of zero-popularity songs.  

### **2. Model Development**  
- 🛠 **Initial Model:**  
  - Low R² (~1%), showing significant unexplained variability.  
- 🔧 **Refinement:**  
  - Removed `acousticness` to address multicollinearity (high VIF values).  
- 🧹 **Filtered Model:**  
  - Excluded zero-popularity songs for better normality and homoscedasticity.  

### **3. Assumption Checks**  
🔍 Residual analysis to assess:  
- 📈 **Normality** (via Q-Q plot and histogram).  
- 📉 **Homoscedasticity** (via residuals vs. fitted plot).  
- 📏 **Linearity**.  

✅ **Improvements:** Filtering and refining the model corrected most assumption violations.  

### **4. Outlier and Influence Analysis**  
- 🔺 **High-Leverage Points:** ~7% of observations were high-leverage, but none excessively influenced the model (Cook’s distance < 1).  

---

## 📊 **Results**  

- **Significant Predictors:**  
  - ✅ `Danceability` **positively impacts popularity**.  
  - ❌ `Energy`, `acousticness`, and `instrumentalness` **negatively impact popularity**.  
- **Refined Model Performance:**  
  - Improved assumptions with better residual distribution and reduced multicollinearity.  

---

## 🏁 **Conclusion**  

✨ The refined model better explains popularity trends, but **most variability remains unexplained**, suggesting other factors at play.  

---

## 🔮 **Recommendations**  

1. **Include More Covariates** 📂  
   - Add features like **song genre**, **release year**, and **artist popularity**.  
2. **Add Interaction Terms** 🔗  
   - Explore how variables like `danceability` and `energy` **interact**.  
3. **Try Advanced Models** 🤖  
   - Use **machine learning** methods like neural networks for deeper insights.  

---

## 🛠 **How to Use**  

1. **Clone Repository** 🖥️  
   ```bash
   git clone https://github.com/your_username/spotify-popularity-analysis.git
   cd spotify-popularity-analysis
