# 🎵 [Spotify Symphony: A Linear Regression Approach on Spotify Data](./Spotify%20Sounds.R)

## Author: **Julian Griffin**

<img src="../Media/SS_Run.gif" alt="Visual of Code" width="70%" />

### 🚀 **Overview**  
&nbsp; So, here's the deal: I was given a dataset of Spotify songs, and instead of just running some basic analysis, I decided to turn it into my own little musical adventure. The question I started with? What actually makes a song popular on Spotify? At first, I thought I’d just plug in some numbers and call it a day. But then as I worked through the math, I started realizing that some of the things that I thought makes a "good" song isn't necessarily what makes it popular. Through Formidable Formulas, Nebulous Numbers, and Enigmatic Equations I embarked on a mathmatical journey into understanding what makes songs tick — and maybe, just maybe, uncover some of the magic behind the Spotify algorithm.

---

## 🎯 **Objectives**  
1. 🕵️‍♂️ Understand the factors influencing **song popularity**.  
2. 🔍 Identify **significant predictors** of popularity using linear regression.  
3. ✅ Ensure **model assumptions** (normality, homoscedasticity, linearity) are met.
4. 🔄 Refine the model for better accuracy.   

---

## 🛠 **Skills and Tools**  
- **Programming Language:** R  
- **Libraries:** `ggplot2`, `lm`, `car`, etc.  
- **Skills Demonstrated:** Data wrangling, linear regression analysis, model diagnostics, hypothesis testing, residual analysis.

---

## 📊 Data Overview  

The `spotify_data.csv` includes information about Spotify songs, focusing on numerical characteristics that may influence song popularity. Below are the covariates analyzed:  

- 🎵 **Popularity**: A measure of how well a track is received, based on streaming counts and social media buzz. 
- ⏳ **Duration_ms**: The length of the track in milliseconds.  
- 💃 **Danceability**: A score reflecting how suitable a track is for dancing.  
- ⚡ **Energy**: An estimate of the intensity and activity level of a track.  
- 🎸 **Acousticness**: A measure of how acoustic (non-electronic) a track sounds.  
- 🎻 **Instrumentalness**: A score that predicts the likelihood of a track being purely instrumental, without vocals.  
- 🎤 **Liveness**: A measure of the presence of an audience in a track, indicating whether it feels like a live performance.  
- 🎚️ **Tempo**: The speed of the track, measured in beats per minute (BPM).  

---

## 🔧 **Methodology** (Parts 1-6)

### **1. 📂 Data Preparation**  
- **Imported** the dataset, previewed its structure, and selected key covariates related to song characteristics.

### **2. 🛠 Model Development**  
- Built an **initial linear regression model** to explore relationships between predictors and song popularity.
- Later, checking VIF values if multicollineariy was skewing our results
- Removed acoustiness and refit the model as it was skewing the model fit

### **3. 🔍 Assumption Checks**  
- Evaluated **model assumptions**:  
  - 📈 **Normality** using Q-Q plots and histograms.  
  - ⚖️ **Homoscedasticity** via residual vs. fitted plots.  
  - 📊 **Linearity** through scatter plots.

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

### **4. 🔄 Model Refinement**  
- Enhanced the model thorough filtering problematic values by:  
  1. 🚫 **Excluding zero-popularity songs**.   
  2. ✂️ **Removing weak predictors** to improve assumptions. For example view the plots below such that the left plot (Duration - Residuals) violates homoscedacity whereas the right plot (Danceability - Residuals) does not.

<p align="center">
  <img src="../Media/SS_Duration.png" alt="Duration Res" width="500"/>
  <img src="../Media/SS_Danceability.png" alt="Dance Res" width="500"/>
</p>

### **5. 🕵️‍♂️ Outliers and Influence Analysis**  
- Analyzed high-leverage and influential points using:  
  - 🎩 **Hat values** for leverage.  
  - 🔥 **Cook’s distance** for influence.

### **6. ✅ Overall Results**  
- Summarized key findings:  
  - 🎉 **Danceability** had a positive relationship on song popularity.  
  - ❌ **Energy, acousticness**, and **instrumentalness** negatively affected popularity.
  - 🔺 Approximately 7% of the data had high leverage despite
  - 🔮 No single observation was disproportionately affecting the model's coefficients. 
  - 📉 Most variability remains **unexplained**.

---

### **Conclusion**  
 
🎵 Turns out, **danceability** is the real MVP of song popularity, while **energy**, **acousticness**, and **instrumentalness** were more like party poopers, dragging down the vibe. Our first crack at the model only scratched the surface, explaining about **1% of the variability** in popularity, and even after some fine-tuning, we’re still only at **0.5%**.  

But hey, progress is progress. We tackled multicollinearity, kicked out zero-popularity songs, and fixed assumption violations like pros. And for those **high-leverage points**? Only **7%** were present, and none of them caused any drama — they were just chill vibes all around.

---

### **Future Recommendations**:

⚠️ Even with all the tweaks and fixes, there’s still a ton of variability in popularity that the model couldn’t explain.

   - 🚀 To point us in the right direction I recommend the following moving forward:

     1. 📂 **Include More Covariates** - Add features such as **song genre**
     2. 🔗 **Add Interaction Terms** -  Explore how variables interact and contribute to song popularity when combined
     3. 🤖  **Try Advanced Models** - Experiment with **machine learning** models to uncover deeper patterns

---
### 📂 Access the R-File  

Click [here](./Spotify%20Sounds.R) to explore the **Spotify Symphony** code in more detail.  


(Note: please download the spotify_data.csv as well and make sure the working directory is set)

