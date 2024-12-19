# 🎵 [Spotify Symphony: A Linear Regression Approach on Spotify Data](./Spotify%20Symphony.R)

<img src="../Media/SS_Run.gif" alt="Visual of Code" width="75%" />

## Author: **Julian Griffin**

### 🚀 **Overview**  
&nbsp; So, here's the deal: I was given a dataset of Spotify songs, and instead of just running some basic analysis, I decided to turn it into my own little musical adventure. The question I started with? What actually makes a song popular on Spotify? At first, I thought I’d just plug in some numbers and call it a day. But then I realized I was diving into a world where songs have hidden personalities—danceability, energy, tempo… all that good stuff. I wanted to know if these features could actually predict a song’s popularity. I mean, if I can figure out the secret sauce behind a viral hit, OMG?

&nbsp; As I worked through the math, I started realizing that some of the things I thought makes a "good" song might not be what makes it popular. Through Formidable Formulas, Nebulous Numbers, and Enigmatic Equations I embarked on a mathmatical journey into understanding what makes songs tick—and maybe, just maybe, uncovering some of the magic behind the Spotify algorithm.

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

- 🎵 **popularity**: A numerical score (0-100) indicating the song's popularity.  
- ⏳ **duration_ms**: Length of the song in milliseconds.  
- 💃 **danceability**: A measure of how suitable a track is for dancing (0-1).  
- ⚡ **energy**: Intensity and activity of a track (0-1).  
- 🎸 **acousticness**: Probability that the track is acoustic (0-1).  
- 🎻 **instrumentalness**: Likelihood of the track being instrumental (0-1).  
- 🎤 **liveness**: Presence of an audience in the recording (0-1).  
- 🎚️ **tempo**: The speed or pace of the song, measured in beats per minute (BPM).

---

## 🔧 **Methodology** (Parts 1-8) 

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
- Created a **full regression model** with all features:

<img src="../Media/SS1.png" alt="Regression Summary" width="400">

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

<img src="../Media/SS_Hist1.png" alt="Histogram Visual" width="600" />

<br>

💡 **Key Findings**:  
- **Normality Violation**: In the residual histogram plot (above), there was an unusually large amount of data at x = -30 suggesting a violation in the normality assumption. This prompted the need for further exploration.
- **Heteroscedasticity**: The funnel shape in the residuals vs. fitted plot suggested heteroscedasticity.  
- **Linearity**: No major issues were detected in the linearity assumption, but further refinement was necessary for normality and homoscedasticity.

✅ Next Steps: To filter the data to correct the assumption errors

---

### **4. Model Refinement**  

🔧 Later, we wanted to adjust the data to better fit the assumptions.  

🔄 **4.1: Exploration of Histogram Discrepancy**  
- We first plotted the popularity scores in a histogram (below) and noticed a large amount of zero values, which may have been affecting our residual plot.

<img src="../Media/SS_Hist2.png" alt="Histogram Visual" width="500"/>

🔍 **Adjustment**:   
1. **Zero-Popularity Songs**: We excluded songs with zero popularity, which significantly improved the normality assumption reducing data noise.

<br>
<br>

🔄 **4.2: Address Homoscedasticity**  
- Next we checked each covariate's residual errors to visual see which were problematic for our assumptions check.
- View examples below, such that a funnel shape pattern is recongizable in the first plot (indicating a violation in Homoscedasticity) vs the second plot with no recongizable pattern (the data is distributed randomly around 0).


<p align="center">
  <img src="../Media/SS_Duration.png" alt="Duration Res" width="500"/>
  <img src="../Media/SS_Danceability.png" alt="Dance Res" width="500"/>
</p>

🔍 **Adjustment**:  

2. **Problematic Predictors**: Removed weaker predictors such as `liveness`, `instrumentalness`, and `duration_ms`, leading to better homoscedasticity and a more interpretable model.  

<br>
<br>

🔄 **4.3: Re-check Assumptions**  

💡 After both of the changes in 4.1 and 4.2 we reported the following: 
  - The **homoscedasticity assumption** was improved, as seen in the residuals.
  - The **residuals** now appear more evenly distributed around zero, supporting the **linearity** assumption.

Example of code used for model refinement:
```R
# Exclude zero-popularity songs
spotify_filtered <- subset(spotify, popularity > 0)

# Refit model on filtered data
model_filtered <- lm(popularity ~ duration_ms + danceability + energy + acousticness + instrumentalness + liveness + tempo, data = spotify_filtered)
summary(model_filtered)

# Exclude problematic predictors for improved homoscedasticity
model_reduced <- lm(popularity ~ danceability + energy + tempo, data = spotify_filtered)
summary(model_reduced)
```

---

### **5. Outliers and Influence Analysis**  

🔍 To ensure the model's robustness, we analyzed outliers and influential observations.  

Example of code used for this analysis:
```R
# Calculate leverage points using hat values
hat_values <- hatvalues(model_reduced)
high_leverage <- mean(hat_values > (2 * length(coef(model_reduced)) / nrow(spotify_filtered)))
cat("High-leverage observations:", high_leverage * 100, "%\n")

# Identify influential points using Cook's Distance
cooks_distance <- cooks.distance(model_reduced)
influential_points <- mean(cooks_distance > 1)
cat("Proportion of influential points:", influential_points * 100, "%\n")
```

💡 **Key Findings**:  
- 🔺 **High-Leverage Points**:  
  - Approximately **7%** of the observations had high leverage, as determined by hat values.  
  - Despite this, none of the observations excessively influenced the model, with Cook's distance remaining below 1.  
- 🔍 **Impact on Results**:  
  - The analysis confirmed that no single observation was disproportionately affecting the model's coefficients.  
  - As a result, the model remained stable, and predictions were not distorted by outliers or influential data points.

---

### **6. Overall Results**  
**Biggest Takeaways**:  
- ✅ `Danceability`: Positive impact on popularity.  
- ❌ `Energy`, `acousticness`, `instrumentalness`: Negative impacts on popularity.  
- 🔮 Refined model assumptions improved.
- 💢 Most variability remains unexplained.  

---

### **7. Conclusion**  
 
🎵 Turns out, **danceability** is the real MVP of song popularity, while **energy**, **acousticness**, and **instrumentalness** were more like party poopers, dragging down the vibe. Our first crack at the model only scratched the surface, explaining about **1% of the variability** in popularity, and even after some fine-tuning, we’re still only at **0.5%**.  

But hey, progress is progress. We tackled multicollinearity, kicked out zero-popularity songs, and fixed assumption violations like pros. And for those **high-leverage points**? Only **7%** were present, and none of them caused any drama — they were just chill vibes all around.

<br>


<img src="../Media/SS12.jpeg" alt="Brain Moving Forward" width="400">

---

### **8. Future Recommendations**:

⚠️ Even with all the tweaks and fixes, there’s still a ton of variability in popularity that the model couldn’t explain. This screams for **new predictors** or maybe even a fresh modeling approach. Future analyses could dive into external factors like **marketing strategies** or **listener demographics** to level up the predictive power and truly crack the code on what makes a song a hit.  

🚀 To point us in the right direction I recommend the following moving forward:

1. **Include More Covariates** 📂  
   - Add features such as **song genre**, **release year**, and **artist popularity** for more comprehensive predictions.  

2. **Add Interaction Terms** 🔗  
   - Explore how variables like `danceability` and `energy` interact and contribute to song popularity when combined.

3. **Try Advanced Models** 🤖  
   - Experiment with **machine learning** models uncover deeper patterns and improve predictions.

---
### 📂 Access the R-File  

Click [here](./Spotify%20Symphony.R) to explore the **Spotify Symphony** code in more detail.  


(Note: please download the spotify_data.csv as well and make sure the working directory is set)
