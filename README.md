# Time Series Analysis
## Part 1. Objective
To ***forecast revenue for the next 12 months*** based on historical monthly performance. 

## Part 2. Data
> ***Table: Monthly Revenue Report of the Fruit Shop***  
> ***Period: January, 2012 - April, 2018***  
> ***Unit: in Thousands NTD***    

| Date   | Rev   |
| :---:  | ---:  |
| Jan-12 | 8.06  |
| Feb-12 | 9.72  |
| Mar-12 | 9.07  |
| Apr-12 | 9.90  |
| ...    | ...   |
| Mar-18 | 38.67 |
| Apr-18 | 44.91 |
 
## Part 3. Outline
### 3.1. General ***ARIMA(p,d,q)*** Model
- ***ARIMA*** stands for ***Autoregressive Integrated Moving Average Models*** and are, in theory, the most general models for forecasting a time series.
- ARIMA Model and its parameters are illustrated as follows: 
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Formula/F_1_ArimaModel.png"/></div>
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Formula/F_2_ArimaParameter.png"/></div>
<br>

- To identify a reasonably appropriate ARIMA model, ideally we need:      
  - ***Observations:*** A minimum of ***n=50*** observations.  
  - ***lag-k:*** The number of sample lag-k autocorrelations and autocorrelations to be calculated should be about ***n/4.*** 

### 3.2. Steps for Model Identification
### Step 1. Choose Proper Transformations
- A series with non-constant variance often needs a ***variance-stabilizing transformations.***
- Tool: R ```Package forecast``` ```BoxCox```
  - Box-Cox’s Transformation:

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Formula/F_3_BoxCox.png"/></div>

### Step 2. Identify the Order of ***d***
#### Option 2.1. Ordinary Differencing 
- To further confirm a necessary degree of differencing so that differenced series is ***stationary.***
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - ***ACF:*** 
    - Stands for ***Autocorrelation Function.***
    - It allows us to incorporate the effect of past values into our model.
  - ***PACF:*** 
    - Stands for ***Partial Autocorrelation Function.***
    - This allows us to set the error of our model as a linear combination of the error values observed at previous time points in the past.
  - If the sample ***ACF*** decays very ***slowly*** and the sample ***PACF*** cuts off after ***lag 1***, then it indicates that differencing is needed.
  
#### Option 2.2. Seasonal Differencing
- To identify if there is a series of changes from one season to the next.
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - If the sample ***ACF*** and the sample ***PACF*** suggest that there might be seasonal structure in the time series, then a seasonal differencing should be further applied.
  
### Step 3. Estimate the Orders of ***p*** and ***q***  
#### Option 3.1. Interpret ACF and PACF Plots

> **3.1.1.1. Compare with the Significance Range**  
- If time series still remains non-stationary after transformations and differencing, an ***AR Model*** or an ***MA Model*** should be fitted.
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - Characteristics of theoretical ACF and PACF for stationary process:

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Formula/F_4_ArimaAcfPacf.png"/></div>
<br>

> **3.1.1.2. Determine Coefficients of the Model**
- If the coefficient estimate of the corresponding lag is ***less than twice of its standard error*** away from zero, it is implied that the autocorrelation at the given lag may not be statistically significant and the elimination of the lag period should be considered.
- Tool: ```Standard Error```

> **3.1.2. Grid Search**
- Iteratively explore different combinations of parameters based on the detection of ***3.1.1.*** 
- Tool: R ```Package TSA``` ```arima```

#### Option 3.2. Compute ESACF
- For an ***ARMA(p,q)*** process, the ***vertex*** of the zero triangle in the asymptotic ESACF will be at ***(p,q)*** position.
- Tool: R ```Package TSA``` ```eacf```
  - ***ESACF:***
    - Stands for ***Extended Sample Autocorrelation Function.*** 
    - A useful tool in model identification, particularly for a mixed ARMA Model.

#### Option 3.3. Automatic ARIMA Modelling
- Return best ARIMA model according to either AIC or BIC value.
- Tool: R ```Package forecast``` ```auto.arima```

### Step 4. Model Selection
- Model with the ***lowest*** AIC or BIC value are being considered the optimal.
- Tool: R ```aic``` ```BIC```

### Step 5. Residual Analysis
#### Step 5.1. Stationary Test

> **Option 5.1.1. Interpret the Plot**
- Tool: R ```plot``` 
> **Option 5.1.2. Augmented Dickey–Fuller (ADF) Test** 
- Null hypothesis: A unit root is present in a time series sample, namely the series is ***not stationary.***
- Tool: R ```Package tseries``` ```adf.test```

#### Step 5.2. Normality Test

> **Option 5.2.1. Interpret the Plot**  
- Tool: R ```qqnorm``` ```qqline``` 
> **Option 5.2.2. Shapiro Test**  
- Null hypothesis: A set of observations is ***normally distributed.***
- Tool: R ```shapiro.test```

#### Step 5.3. Autocorrelation Test  

> **Ljung-Box Q (LBQ) Test**
- Null hypothesis: The first k autocorrelations are jointly zero, namely the data values are ***independent*** up to lag k.
- Tool: R ```Package tseries``` ```Box.test```

### Step 6. Model Evaluation
#### Step 6.1. Training
#### Step 6.2. Validation
- Tool: R ```Package forecast``` ```Arima```

### Step 7. Prediction
- Tool: R ```Package forecast``` ```Arima```

## Part 4. Steps
> [**Complete Code**](https://github.com/lclh813/Time_Series_Analysis/blob/master/Code/CompleteCode.R)

### Analysis Process
- Time series analysis of the given data was performed in accordance with the flow of ***blue arrows***.

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_0_FlowChart.png"/></div>
<br>

### Preparation
- Import library.
```
library(forecast)
library(TSA)
library(tseries)
```
- Import data.
```
data <- read.table("G:\\data.txt", header=TRUE)
```
- Split data into training and validation sets and declare the ***training set*** as variable ***Zt***.
```
Zt <- data$Rev[-c(73:76)]
```

### Step 1. Choose Proper Transformations
- Other than the defaulted method of Box-Cox Transforamtion ***"guerrero,"*** there is another transformation method ***"loglik."***
- Since lambda calculated by "loglik" is not much different from that calculated by "guerrero," lambda calculated by "guerrero" will be applied.
```
lambda <- BoxCox.lambda(Zt, method="guerrero")
```
- According to Box-Cox’s Transformation, the original data should be applied an exponent of ***0.23*** to make its variance stabilized.
```
Yt <- (abs(Zt))^(lambda)
```
- Compare the plot of the original data ***Zt*** to that of the transformed data ***Yt,*** and the line of ***Yt*** is seen to be relatively stabilizing with smaller volatility.
```
par(mfrow = c(1,2))
ts.plot(Zt); ts.plot(Yt)
```
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_1_1_ZtYt.png"/></div>

- After variance stabilizing transformation, the sample ***ACF*** decays very slowly, which suggests that ***ordinary differencing*** should be applied.
```
par(mfrow=c(1,2))
acf(Yt, lag=25); pacf(Yt, lag=25)
```
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_1_2_YtACFPACF.png"/></div>

### Step 2. Identfy the Order of ***d***  
#### Step 2.1. Ordinary Differencing
- The series remains non-stationary after 1st differencing; in addition, as the plot of ***ACF*** of the differenced series ***dYt*** suggests, there is a seasonal pattern that repeats ***every 4 months*** and therefore ***seasonal differencing*** should be applied.
```
dYt <- diff(Yt) 
acf(dYt, lag=25); pacf(dYt, lag=25)
```
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_2_1_dYtACFPACF.png"/></div>

#### Step 2.2. Seasonal Differencing
- Also, since the original data was recorded on a ***monthly*** basis, dividing data into ***12*** groups which represent ***January to December*** respectively can help us gain more insights into seasonal patterns.
```
time1 <- c(rep(1:12,6))
par(mfrow=c(1,1))
monthplot(Yt, phase=time1, xlab="month", ylab="Yt")
```
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_2_2_1_12Groups.png"/></div>

- It can be further observed that ***January to April***, ***May to August***, ***September to December*** can be classified as ***3*** different groups. 
```
time2 <- c(rep(rep(c(1:3), each=4),6))
par(mfrow=c(1,1))
monthplot(Yt, phase=time2, ylab="Yt")
```
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_2_2_2_3Groups.png"/></div>

- Since a seasonal trend can be inferred from plots of ACF and PACF and also from those of grouped data divided into 12 and 3 groups, ***seasonal differencing*** with period ***4*** should be applied.
```
dYt_s <- diff(dYt,4,1)
par(mfrow=c(1,2))
acf(dYt_s, lag=25); pacf(dYt_s, lag=25)
```
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_2_2_3_dYtsACFPACF.png"/></div>

### Step 3. Estimate the Orders of ***p*** and ***q***  
#### Option 3.1. Interpret ACF and PACF Plots
> **3.1.1.1. Compare with the Significance Range** 
- Significance range is indicated with ***blue dotted lines*** which represent positive and negative values of ***standard error.***
- After seasonal differencing, the series still remains non-stationary with ***ACF*** exceeding significance range at ***lag 4*** and ***lag 5*** and ***PACF*** at ***lag 4*** ; therefore, ***ARMA(4,4)*** and ***ARMA(4,5)*** should be further fitted.
- Since all the coefficients of ***ARMA(4,5)*** are less than ***twice*** of their respective ***standard errors,*** ***ARMA(4,5)*** may not be the proper model and further analysis will be focused on ***ARMA(4,4).***

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_1_1_0_Model0.png"/></div>
<br>

> **Model 1. (4,1,4) x (0,1,0)_4**
```
m1 <- arima(Yt, order=c(4,1,4),
            seasonal=list(order=c(0,1,0), period=4))
acf(m1$residuals, lag=20); pacf(m1$residuals, lag=20)
```
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_1_1_1_Model1.png"/></div>
<br>

> **3.1.1.2. Determine Coefficients of the Model**

> **Model 2. (1,1,4) x (0,1,0)_4 with coefficients of MA(2) and MA(3) being set as zero**
- Since coefficients of ***AR(2), AR(3), AR(4), MA(2), MA(3)*** are less than ***twice*** of their respective ***standard errors***, ***Model 1*** can be modified by setting coefficients of above-mentioned as ***zero***.
```
m2 <- arima(Yt, order=c(1,1,4), fixed=c(NA,NA,0,0,NA),
            seasonal=list(order=c(0,1,0), period=4))
acf(m2$residuals, lag=20); pacf(m2$residuals, lag=20)
```
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_1_1_2_Model2.png"/></div>
<br>

> **3.1.2. Grid Search**

> **Model 3. (1,1,4) x (0,1,0)_4**
- Minimum of ***AIC*** and ***BIC*** are both the ***11th*** one in the grid, which suggests that ***(1,1,4)*** is the optimal ARIMA model.
```
aic <- Bic <- c()
for (p in c(0:5)) {
  for (q in c(0:5)) {
    result <- arima(dYt_s, order=c(p,0,q))
    aic[p*6+(q+1)] <- result$aic
    Bic[p*6+(q+1)] <- BIC(result)
    cat("p=", p, "q=", q ,"AIC = ", aic[p*6+(q+1)],"BIC = ",Bic[p*6+(q+1)] ,"\n")
  }}
which(aic == min(aic))
which(Bic == min(Bic))
```
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_1_2_Model3.png"/></div>
<br>

```
m3 <- arima(Yt, order=c(1,1,4), 
            seasonal=list(order=c(0,1,0), period=4))
acf(m3$residuals, lag=20); pacf(m3$residuals, lag=20)
```

#### Option 3.2. Compute ESACF
- When ***ar.max*** and ***ma.max*** are larger than ***17***, there pops up an error message suggesting that the matrix may become singular without invertible matrix to perform further algebraic computation.
> **Model 4. (1,1,4) x (0,1,0)_4**
- The ***vertex*** of the zero triangle is at ***(2,3)*** position.
- Since the input is the differenced data already, the result of ***(2,3)*** should be considered as ***(2,1,3) x (0,1,0)_4.***
```
eacf(dYt_s, ar.max=16, ma.max=16)
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_2_Model4.png"/></div>
<br>

**Option 3.3. Automatic ARIMA Modelling**
> **Model 5. (1,1,0) x (0,1,0)_4**
- Since the input is the differenced data already, the result of ***(1,0,0)*** should be considered as ***(1,1,0) x (0,1,0)_4.***
```
auto.arima(dYt_s)
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_3_Model5.png"/></div>
<br>

### Step 4. Model Selection
- ***Model 2. (1,1,4) x (0,1,0)_4 with coefficients of MA(2) and MA(3) being set as zero*** has the smallest AIC and BIC and therefore is considered to be optimal and can be summarized by the following equation.

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_4_1_ForecastingModel.png"/></div>
<br>

- Note that the absolute value of ***theta*** being ***smaller than 1*** is the sufficient condition for a ***MA(1)*** process to be ***invertible.*** When a MA(1) is ***not invertible,*** the coefficients of the time series model is not decremented along with the increase of lag order, which suggests that an unforeseeable impact (*exogenous shock*) of long time ago is likely to have greater influence on today than recent dates does. Thus, since there is a coefficient of the MA part ***greater than 1,*** the explanatory power of ***Model 2*** should be taken with prudence.      

- If AIC and BIC suggest different lag orders, the model with the smallest ***BIC*** should be considered the optimal because BIC is a ***consistent model selection*** criterion while AIC is not.

#### Option 4.1. Create table T1 to facilitate the comparison of AIC and BIC.
```
T1 <- data.frame(matrix(c(BIC(m1),BIC(m2),BIC(m3),BIC(m4),BIC(m5),
                          m1$aic,m2$aic,m3$aic,m4$aic,m5$aic),
                          ncol=5, nrow=2, byrow=T))
colnames(T1)=c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5")
rownames(T1)=c("BIC", "AIC")
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_4_2_Table1.png"/></div>
<br>

#### Option 4.2. Create table T2 to rank AIC and BIC in ascending order.
```
a1 <- rank(c(BIC(m1),BIC(m2),BIC(m3),BIC(m4),BIC(m5)))
a2 <- rank(c(m1$aic,m2$aic,m3$aic,m4$aic,m5$aic))
T2 <- data.frame(rbind(a1,a2))
colnames(T2)=c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5")
rownames(T2)=c("BIC Rank","AIC Rank")
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_4_3_Table2.png"/></div>
<br>

### Step 5. Residual Analysis
#### Step 5.1. Stationary Test
#### Option 5.1.1. Interpret the Plot
```
par(mfrow=c(1,1))
ts.plot(m2$residuals); abline(h=0, col=2)
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_5_1_1_StationaryPlot.png"/></div>
<br>

#### Option 5.1.2. Augmented Dickey–Fuller (ADF) Test
- Null hypothesis (H0): The series is ***not stationary***.
- p-value = 0.01 suggesting that H0 can be rejected, namely the series is ***stationary*** which indicates that there is no seasonal effects left to be further extracted.

```
adf.test(m2$residuals)
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_5_1_2_StationaryADF.png"/></div>
<br>

#### step 5.2. Normality Test
#### Option 5.2.1. Interpret the Plot
- Points are lying away from the ***45-degree line***, which indicates that the series is ***not normally*** distributed.

```
par(mfrow=c(1,1))
qqnorm(m2$residuals); qqline(m2$residuals, col=2)
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_5_2_1_NormalityPlot.png"/></div>
<br>

#### Option 5.2.2. Shapiro Test
- Null hypothesis (H0): A set of observations is ***normally*** distributed.
- p-value = 0.02 suggesting that H0 can be rejected, namely the series is ***not normally*** distributed and therfore the model is expected to have ***lower*** forecast accuracy. 

```
shapiro.test((m2$residuals))
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_5_2_2_NormalityShapiro.png"/></div>
<br>

#### Step 5.3. Autocorrelation Test
- Null hypothesis (H0): Data values are ***independent*** up to lag k.
- p-values of lag 1 to lag 20 are ***above*** the line of 0.05, which suggests that H0 cannot be rejected and residuals are ***not autocorrelated***.

```
p1 <- rep(0,20)
for(i in 1:20){
  p1[i] <- Box.test(m2$residual, lag=i, type="Ljung")$p.value}
par(mfrow=c(1,1))
plot(p1, ylim=c(0,1), ylab="p", pch=3)
abline(h=0.05, col=2)
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_5_3_AutocorrelationPlot.png"/></div>
<br>

### Step 6. Model Evaluation
#### Step 6.1. Training: Fit the Model by Using the Training Data
```
fit <- Arima(Yt, order=c(1,1,4), fixed=c(NA,NA,0,0,NA),
            seasonal=list(order=c(0,1,0), period=4))
future <- forecast(fit, h=4)
future
```

#### Step 6.2. Validation: Compare with the Actual Data
- Since the actual data fall within the confidence interval of 80% and 95%, the forecasting power of the ***Model 2*** is considered to be satisfactory. 

```
par(mfrow = c(1,1))
plot(future, xlim=c(60,76))
points(c(60:76), c(rep(0,13), (data$Rev[c(73:76)])^(lambda)), col="red")
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_6_2_Validation.png"/></div>
<br>

### Step 7. Prediction
- Notice that the predicted outcome needs to be back-transformed to original scale.
```
pred_Yt <- forecast(fit, h=16)
pred_Zt <- pred_Yt[[4]][5:16]^(1/lambda)
par(mfrow = c(1,1))
ts.plot(data, xlim=c(1,88), ylim=c(1,50))
lines(77:88, pred_Zt, col=2)
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_7_Prediction.png"/></div>
<br>

## Part 5. Reference
- [NTHU STAT 5410 - Linear Models](http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php)
  - by ***Shao-Wei Cheng***, Institute of Statistics, National Tsing Hua University
- [Time Series Analysis: Univariate and Multivariate Methods](https://www.amazon.com/Time-Analysis-Univariate-Multivariate-Methods/dp/0321322169) 
  - by ***William W.S. Wei***
- [R Documentation](https://www.rdocumentation.org/)
