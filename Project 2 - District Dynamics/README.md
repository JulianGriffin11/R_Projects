# [🏢 District Dynamics: Housing Market Analysis 🏢](./District%20Dynamics.R)

<img src="../Media/SS_Run.gif" alt="Visual of Code" width="70%" />

---

## 🚀 **Introduction**  
Welcome to *District Dynamics*! This project explores a dataset of real estate transactions to uncover factors affecting housing prices. By focusing on price per square foot, this analysis digs into variables like lot size, number of bedrooms, and sale date. The journey blends data wrangling, model building, and regression diagnostics to better understand price variability in the housing market.

---

## 🎯 **Objectives**  
1. 📊 Identify key factors influencing **price per square foot**.  
2. ✅ Ensure **variable selection** is maximized.  
3. ⏪ Check for **possible outliers** influencing the model. 

---

## 🛠 **Skills and Tools**  
- **Programming Language:** R
- **Libraries:** `leaps`, `car` 
- **Skills Demonstrated:** Outlier detection, multicollinearity checks, data cleaning, linear regression, model refinement

---

## 📊 **Data Overview**  
The clean_data.csv contains detailed housing data. Key variables include:

- **Sale_price**: Total sale price of the house.
- **Lotsize**: Size of the lot in square feet.
- **Fin_sqft**: Finished square footage of the house.
- **Sale_date**: Date of the transaction.
- **Year_Built**: Year the house was constructed.
- **District**: A categorical variable representing neighbourhoods.
- **Bdrms**: Number of bedrooms.

A log-transformed variable, **ppsq** (price per square foot), serves as the dependent variable.

---

## 🔧 **Methodology** (Steps 1-6)

### **1. 📂 Data Wrangling**  
- Loaded the dataset and filtered out unrealistic values:
  - **Lotsize > 0**
  - **Sale_price ≥ $10,000**
  - **Fin_sqft ≥ 500**
- Computed **log-transformed price per square foot**.

### **2. ⚙️ Model Construction**  

- Developed an initial multiple linear regression model:
``` R
linear_model <- lm(ppsq ~ log(Lotsize) + Sale_date + Year_Built + District + Bdrms, data = clean_data_refit)
summary(linear_model)
```

- Checked multicollinearity with Variance Inflation Factor (VIF):
``` R
vif(linear_model)
```


### **3. 🔄 Model Refinement**  
- Performed **all-subsets regression** using the leaps package:
R
all <- leaps::regsubsets(ppsq ~ log(Lotsize) + Sale_date + Year_Built + District + Bdrms, data = clean_data_refit, nvmax = 50)
plot(all, scale = "adjr2")


### **4. 🥵 Outlier & Influence Analysis**  
- Identified high-leverage points and influential observations:
R
hat_values <- hatvalues(linear_model)
high_leverage <- mean(hat_values > (2 * length(coef(linear_model)) / nrow(clean_data_refit)))
cat("High-leverage observations:", high_leverage * 100, "%\n")


### **5. ⚖️ Key Findings**  
- The model explains **21% of the variability** in price per square foot.
- Significant predictors: **log(Lotsize)**, **Sale_date**, **Year_Built**, **Bdrms**.
- Multicollinearity was **not significant**.

### **6. 🧐 Final Thoughts**  
- The model performs reasonably well but could be improved by refining categorical variables like **District**.

---

## 🔒 **Conclusions & Recommendations**

### **Key Conclusions**
- Larger lots and newer construction correlate with higher price per square foot.
- Sale date trends reflect possible market shifts.

### **Recommendations**
1. **Enhance District Variable**: Break it down into more detailed neighbourhoods.
2. **Assumption Testing**: Ensure robustness with assumption diagnostics.
3. **Explore Machine Learning**: Use models like random forests for better accuracy.

---

### 📂 **Access the R File**  
Click [here](./District_Dynamics.R) to view the full code.

*(Ensure the working directory is set to your local environment)*

---

- Discover my other work:
  - [📊 SQL Projects](https://github.com/JulianGriffin11/SQL_Projects)  
  - [📃 Excel Projects](https://github.com/JulianGriffin11/Excel_Projects)

Sincerely,  
Julian
