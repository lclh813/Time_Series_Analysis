# Time Series Analysis
## Notice
It is possible that GitHub fails to display Jupyter Notebooks. Should such circumstances arise, please refer to ***Part 4. Steps*** listed below for code samples.
## Part 1. Objective
## Part 2. Data
## Part 3. Outline
### 3.1. Reference
- [A Guide to Time Series Forecasting with ARIMA in Python 3](https://www.digitalocean.com/community/tutorials/a-guide-to-time-series-forecasting-with-arima-in-python-3)
  - by ***Thomas Vincent***
- [NTHU STAT 5410 - Linear Models](http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php)
  - by ***Shao-Wei Cheng***, Institute of Statistics, National Tsing Hua University
- [Time Series Analysis: Univariate and Multivariate Methods](https://www.amazon.com/Time-Analysis-Univariate-Multivariate-Methods/dp/0321322169) 
  - by ***William W.S. Wei***

### 3.2. General ***ARIMA(p,d,q)*** Model
- ***ARIMA*** stands for ***Autoregressive Integrated Moving Average Models*** and are, in theory, the most general models for forecasting a time series.
- ARIMA Model and its parameters are illustrated as follows: 
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/ArimaModel.png"/></div>
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/ArimaParameter.png"/></div>
<br>

- To identify a reasonably appropriate ARIMA model, ideally we need:      
  - ***Observations:*** A minimum of ***n=50*** observations.  
  - ***lag-k:*** The number of sample lag-k autocorrelations and autocorrelations to be calculated should be about ***n/4.*** 

### 3.3. Steps for Model Identification
### Step 1. Plot the Time Series Data and Choose Proper Transformations
- A series with non-constant variance often needs a ***variance-stabilizing transformations.***
- Tool: R ```library(forecast)``` ```BoxCox```
  - ***Box-Cox’s Transformation:***

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/BoxCox.png"/></div>

### Step 2. Identfy the Order of ***d***
### Step 2.1. Ordinary Differencing
- To further confirm a necessary degree of differencing so that differenced series is ***stationary.***
- Tool: R ```acf``` ```pacf```
  - ***ACF:*** 
    - Stands for ***Autocorrelation Function.***
    - It allows us to incorporate the effect of past values into our model.
  - ***PACF:*** 
    - Stands for ***Partial Autocorrelation Function.***
    - This allows us to set the error of our model as a linear combination of the error values observed at previous time points in the past.
  - If the sample ***ACF*** decays very ***slowly*** and the sample ***PACF*** cuts off after ***lag 1***, then it indicates that differencing is needed.
  
### Step 2.2. Seasonal Differencing
- To identify if there is a series of changes from one season to the next.
- Tool: R ```acf``` ```pacf```
  - If the sample ***ACF*** and the sample ***PACF*** suggest that there might be seasonal structure in the time series, then a seasonal differencing should be further applied.
  
### Step 3. Identfy the Orders of ***p*** and ***q***
### Option 3.1. Interpret ACF and PACF Plots
- If there still remains trend in the time series after transformations and differencing, an ***AR Model*** or an ***MA Model*** should be fitted.
- Tool: R ```acf``` ```pacf```
  - Characteristics of theoretical ACF and PACF for stationary process:

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/ArimaAcfPacf.png"/></div>

### Option 3.2. Compute ESACF
- For an ARMA(p,q) process, the ***vertex*** of the zero triangle in the asymptotic ESACF will be at ***(p,q)*** position.
- Tool: R ```library(TSA)``` ```eacf```

, which stands for ***Extended Sample Autocorrelation Function*** 

  
### Step 4. Determine the Coefficients of the Model
- If the coefficient estimate of the corresponding lag is ***less than twice of its standard error*** away from 0, it is implied that the autocorrelation at the given lag may not be significant and the elimination of the lag period should be considered.
- Tool: ```Standard Error```








### 3.2. 

### Reference
Professor Shao-Wei, Cheng
Institute of Statistics, National Tsing Hua University
http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php
https://people.duke.edu/~rnau/411arim.htm
- 08. Mean Structure and Transformation




## Part 4. Steps

Step 1. Plot the time series data and choose proper transformations.  
Step 2. Compute and examine the sample ACF and the sample of PACF of the original series.
