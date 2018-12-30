# Time Series Analysis
## Notice
It is possible that GitHub fails to display Jupyter Notebooks. Should such circumstances arise, please refer to ***Part 4. Steps*** listed below for code samples.
## Part 1. Objective
## Part 2. Data
## Part 3. Outline
### 3.1. General ARIMA(p,d,q) Model
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

### 3.2. Steps for Model Identification
### Step 1. Plot the Time Series Data and Choose Proper Transformations
- To ***stabilize*** a series with nonconstant variance.
- Tool: ```Box-Cox’s Transformation```

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/BoxCox.png"/></div>

### Step 2. Identfy the Order of ***d***
### Step 2.1. Ordinary Differencing
- To make a non-stationary series ***stationary.***
- Tool: ```ACF``` ```PACF```
  - If the sample ***ACF*** decays very ***slowly*** and the sample ***PACF*** cuts off after ***lag 1***, then it indicates that differencing  is needed.
  
### Step 2.2. Seasonal Differencing
- To identify if there is a series of changes from one season to the next.
- Tool: ```ACF``` ```PACF```
  - If the sample ***ACF*** and the sample ***PACF*** suggest that there might be seasonal structure in the time series, then a seasonal differencing should be further applied.
  
### Step 3. Identfy the Orders of ***p*** and ***q***
- Characteristics of theoretical ACF and PACF for stationary process are illustrated as follows:
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/ArimaAcfPacf.png"/></div>
<br>
  
### 3.5. Determine the Coefficients of the Model
- If the coefficient estimate of the corresponding lag is ***less than twice its standard error*** away from 0, the correlation may not be significant enough and therefore should be eliminated from the linear regression.





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
