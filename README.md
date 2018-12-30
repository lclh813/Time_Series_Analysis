# Time Series Analysis
## Part 1. Objective
## Part 2. Data
## Part 3. Outline
### 3.1. General ***ARIMA(p,d,q)*** Model

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/ARIMA.png"/></div>


- ***p:*** The highest order in the ***autoregressive polynomial.*** Usually ***p*** is less than or equal to ***3.***
- ***q:*** The highest order in the ***moving average polynomial.*** Usually ***q*** is less than or equal to ***3.***
- ***d:*** The order of ***differencing.*** In most cases, ***d*** is either ***0, 1, or 2***. 

### 3.2. Plot the Time Series Data and Choose Proper Transfornations
- To ***stabilize*** a series with nonconstant variance.
- Tool: ```Box-Cox’s Transformation```
- ***Box-Cox’s Transformation*** 

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/BoxCox.png"/></div>

### 3.3. Confirm a Necessary Degree of Differencing
### 3.3.1. Ordinary Differencing
- To make a non-stationary series ***stationary.***
- Tool: ```ACF``` ```PACF```
  - If the sample ***ACF*** decays very ***slowly*** and the sample ***PACF*** cuts off after ***lag 1***, then it indicates that differencing  is needed.
  
### 3.3.2. Seasonal Differencing
- To identify if there is a series of changes from one season to the next.
- Tool: ```ACF``` ```PACF```
  - If the sample ***ACF*** and the sample ***PACF*** suggest that there might be seasonal structure in the time series, then a seasonal differencing should be further applied.
  
### 3.4. Identfy the Orders of ***p*** and ***q***
  
### 3.5. Determine the Coefficient of the Model


### 3.2. 

### Reference
Professor Shao-Wei, Cheng
Institute of Statistics, National Tsing Hua University
http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php
- 08. Mean Structure and Transformation




## Part 4. Steps

Step 1. Plot the time series data and choose proper transformations.  
Step 2. Compute and examine the sample ACF and the sample of PACF of the original series.
