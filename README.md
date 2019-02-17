# Time Series Analysis
## Notice
It is possible that GitHub fails to display Jupyter Notebooks. Should such circumstances arise, please refer to ***Part 4. Steps*** listed below for code samples.
## Part 1. Objective
## Part 2. Data
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
- Tool: R ```Package forecast``` ```arima```

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

## Part 4. Steps
> [**Complete Code: R**]

### Analysis Process
- Time series analysis of the given data was performed in accordance with the flow of ***red arrows***.

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
data <- read.table("G:\\data.csv")
```
- Split data into training and validation sets and declare the ***training set*** as variable ***Zt***.
```
Zt <- data$V1[-c(73:76)]
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
> **3.1.1. Compare with the Significance Range** 
- Significance range is indicated with ***blue dotted lines*** which represent positive and negative values of ***standard error.***
- After seasonal differencing, the series still remains non-stationary with ***ACF*** exceeding significance range at ***lag 4*** and ***lag 5*** and ***PACF*** at ***lag 4*** ; therefore, ***ARMA(4,4)*** and ***ARMA(4,5)*** should be further fitted.
- Since all the coefficients of ***ARMA(4,5)*** are less than ***twice*** of their respective ***standard errors,*** ***ARMA(4,5)*** may not be the proper model and further analysis will be focused on ***ARMA(4,4).***

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_1_0_Model0.png"/></div>
<br>

> **Model 1. (4,1,4) x (0,1,0)_4**
```
m1 <- arima(Yt, order=c(4,1,4),
            seasonal=list(order=c(0,1,0), period=4))
acf(m1$residuals, lag=20); pacf(m1$residuals, lag=20)
```
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_1_1_Model1.png"/></div>
<br>

> **3.1.2. Determine Coefficients of the Model**

> **Model 2. (1,1,4) x (0,1,0)_4 with coefficients of MA(2) and MA(3) being set as zero**
- Since coefficients of ***AR(2), AR(3), AR(4), MA(2), MA(3)*** are less than ***twice*** of their respective ***standard errors***, ***Model 1*** can be modified by setting coefficients of above-mentioned as ***zero***.
```
m2 <- arima(Yt, order=c(1,1,4),fixed=c(NA,NA,0,0,NA),
            seasonal=list(order=c(0,1,0), period=4))
acf(m2$residuals, lag=20); pacf(m2$residuals, lag=20)
```
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_1_2_Model2.png"/></div>
<br>

> **3.1.3. Grid Search**

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
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_1_3_Model3.png"/></div>
<br>

```
m3 <- arima(Yt, order=c(1,1,4), 
            seasonal=list(order=c(0,1,0), period=4))
acf(m3$residuals, lag=20); pacf(m3$residuals, lag=20)
```

#### Option 3.2. Compute ESACF
- When ***ar.max*** and ***ma.max*** are larger than ***16***, there pops up an error message suggesting that the matrix may become singular without invertible matrix to perform further algebraic computation.
> **Model 4. (1,1,4) x (0,1,0)_4**
- The ***vertex*** of the zero triangle is at ***(2,3)*** position.
- Since the input is the differenced data already, the result of ***(2,3)*** should be considered as ***(2,1,3) x (0,1,0)_4.***
```
eacf(dYt_s, ar.max=16, ma.max=16)
```

<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/Pic/P_3_2_Model4.png"/></div>
<br>

==================================================================================================







++++++++++










**Option 3.3. Automatic ARIMA Modelling**
> [**Model 5. (2,1,1) x (0,1,0)_4**](https://github.com/lclh813/Time_Series_Analysis/blob/master/Code/C_3_3_M5.R)

[**Step 4. Model Selection**](https://github.com/lclh813/Time_Series_Analysis/blob/master/Code/C_4_ModelSelection.R)


## Part 5. Reference
- [NTHU STAT 5410 - Linear Models](http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php)
  - by ***Shao-Wei Cheng***, Institute of Statistics, National Tsing Hua University
- [Time Series Analysis: Univariate and Multivariate Methods](https://www.amazon.com/Time-Analysis-Univariate-Multivariate-Methods/dp/0321322169) 
  - by ***William W.S. Wei***
- [A Guide to Time Series Forecasting with ARIMA in Python 3](https://www.digitalocean.com/community/tutorials/a-guide-to-time-series-forecasting-with-arima-in-python-3)
  - by ***Thomas Vincent***
- [R Documentation](https://www.rdocumentation.org/)
- [Wikipedia](https://www.wikipedia.org/)

