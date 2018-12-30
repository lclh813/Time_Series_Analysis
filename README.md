# Time Series Analysis
## Notice
It is possible that GitHub fails to display Jupyter Notebooks. Should such circumstances arise, please refer to ***Part 4. Steps*** listed below for code samples.
## Part 1. Objective
## Part 2. Data
## Part 3. Outline
### 3.1. Reference
- [NTHU STAT 5410 - Linear Models](http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php)
  - by ***Shao-Wei Cheng***, Institute of Statistics, National Tsing Hua University
- [Time Series Analysis: Univariate and Multivariate Methods](https://www.amazon.com/Time-Analysis-Univariate-Multivariate-Methods/dp/0321322169) 
  - by ***William W.S. Wei***
- [A Guide to Time Series Forecasting with ARIMA in Python 3](https://www.digitalocean.com/community/tutorials/a-guide-to-time-series-forecasting-with-arima-in-python-3)
  - by ***Thomas Vincent***
- [R Documentation](https://www.rdocumentation.org/)

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
- Tool: R ```Package forecast``` ```BoxCox```
  - ***Box-Cox’s Transformation:***

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/BoxCox.png"/></div>

### Step 2. Identfy the Order of ***d***
> **Step 2.1. Ordinary Differencing**
- To further confirm a necessary degree of differencing so that differenced series is ***stationary.***
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - ***ACF:*** 
    - Stands for ***Autocorrelation Function.***
    - It allows us to incorporate the effect of past values into our model.
  - ***PACF:*** 
    - Stands for ***Partial Autocorrelation Function.***
    - This allows us to set the error of our model as a linear combination of the error values observed at previous time points in the past.
  - If the sample ***ACF*** decays very ***slowly*** and the sample ***PACF*** cuts off after ***lag 1***, then it indicates that differencing is needed.
  
> **Step 2.2. Seasonal Differencing**
- To identify if there is a series of changes from one season to the next.
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - If the sample ***ACF*** and the sample ***PACF*** suggest that there might be seasonal structure in the time series, then a seasonal differencing should be further applied.
  
### Step 3. Identfy the Orders of ***p*** and ***q***
> **Step 3.1. Interpret ACF and PACF Plots**
- If there still remains trend in the time series after transformations and differencing, an ***AR Model*** or an ***MA Model*** should be fitted.
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - Characteristics of theoretical ACF and PACF for stationary process:

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/ArimaAcfPacf.png"/></div>
<br>
> **Step 3.2. Determine the Coefficients of the Model**
- If the coefficient estimate of the corresponding lag is ***less than twice of its standard error*** away from 0, it is implied that the autocorrelation at the given lag may not be significant and the elimination of the lag period should be considered.
- Tool: ```Standard Error```

> **Step 3.3. Compute ESACF**
- For an ***ARMA(p,q)*** process, the ***vertex*** of the zero triangle in the asymptotic ESACF will be at ***(p,q)*** position.
- Tool: R ```Package TSA``` ```eacf```
  - ***ESACF:***
    - Stands for ***Extended Sample Autocorrelation Function.*** 
    - A useful tool in model identification, particularly for a mixed ARMA Model.

> **Step 3.4. Automatic ARIMA Modelling**
- Return best ARIMA model according to either AIC, AICc or BIC value.
- Tool: R ```Package forecast``` ```auto.arima```

> **Step 3.5. Model Selection by AIC and BIC**
- Model with the ***lowest*** AIC or BIC value are being considered the **optimal.**
- Tool: R ```aic``` ```BIC```

