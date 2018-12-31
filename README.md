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
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/F_1_ArimaModel.png"/></div>
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/F_2_ArimaParameter.png"/></div>
<br>

- To identify a reasonably appropriate ARIMA model, ideally we need:      
  - ***Observations:*** A minimum of ***n=50*** observations.  
  - ***lag-k:*** The number of sample lag-k autocorrelations and autocorrelations to be calculated should be about ***n/4.*** 

### 3.2. Steps for Model Identification
### Step 1. Plot the Time Series Data and Choose Proper Transformations
- A series with non-constant variance often needs a ***variance-stabilizing transformations.***
- Tool: R ```Package forecast``` ```BoxCox```
  - Box-Cox’s Transformation:

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/F_3_BoxCox.png"/></div>

### Step 2. Identfy the Order of ***d***
#### Step 2.1. Ordinary Differencing 
- To further confirm a necessary degree of differencing so that differenced series is ***stationary.***
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - ***ACF:*** 
    - Stands for ***Autocorrelation Function.***
    - It allows us to incorporate the effect of past values into our model.
  - ***PACF:*** 
    - Stands for ***Partial Autocorrelation Function.***
    - This allows us to set the error of our model as a linear combination of the error values observed at previous time points in the past.
  - If the sample ***ACF*** decays very ***slowly*** and the sample ***PACF*** cuts off after ***lag 1***, then it indicates that differencing is needed.
  
#### Step 2.2. Seasonal Differencing
- To identify if there is a series of changes from one season to the next.
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - If the sample ***ACF*** and the sample ***PACF*** suggest that there might be seasonal structure in the time series, then a seasonal differencing should be further applied.
  
### Step 3. Estimate the Orders of ***p*** and ***q***  
#### Option 3.1. Interpret ACF and PACF Plots

> **3.1.1. Compare with the Significance Range**  
- If time series still remains non-stationary after transformations and differencing, an ***AR Model*** or an ***MA Model*** should be fitted.
- Tool: R ```Package TSA``` ```acf``` ```pacf```
  - Characteristics of theoretical ACF and PACF for stationary process:

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/F_4_ArimaAcfPacf.png"/></div>
<br>

> **3.1.2. Determine the Coefficients of the Model**
- If the coefficient estimate of the corresponding lag is ***less than twice of its standard error*** away from zero, it is implied that the autocorrelation at the given lag may not be statistically significant and the elimination of the lag period should be considered.
- Tool: ```Standard Error```

> **3.1.3. Grid Search**
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

### Step 4. Identify the Orders of ***p*** and ***q***
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
[**Step 1. Plot the Time Series Data and Choose Proper Transformations**](https://github.com/lclh813/Time_Series_Analysis/blob/master/C_1_Transformation.R)
- According to ***Box-Cox’s Transformation,*** the original data should be applied an exponent of ***0.16*** to make its variance stabilized.
- Compare the plot of the original data ***Zt*** to that of the transformed data ***Yt,*** the line of ***Yt*** is seen to be relatively stabilizing.

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/P_1_1_Transformation.png"/></div>

- After variance stabilizing transformation, the sample ACF decays very slowly, which suggests that ordinary differencing should be applied.

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/P_1_2_TransformationAcfPacf.png"/></div>

**Step 2. Identfy the Order of** ***d***  
[**Step 2.1. Ordinary Differencing**](https://github.com/lclh813/Time_Series_Analysis/blob/master/C_2_1_OrdinaryDiff.R)
- After ordinary differencing, the sample ACF indicates that there is a seasonal trend with peaks occurring at lags of 4, which suggests that seasonal differencing should be applied.

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/P_2_1_OrdinaryDiffAcfPacf.png"/></div>

[**Step 2.2. Seasonal Differencing**](https://github.com/lclh813/Time_Series_Analysis/blob/master/C_2_2_SeasonalDiff.R)

- After seasonal differencing, the series still remains non-stationary with values of both ACF and PACF exceeding twice of their respective standard errors at lag 4, ***ARMA(4,4)*** should be further fitted. 

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/P_2_2_SeasonalDiffAcfPacf.png"/></div>

**Step 3. Estimate the Orders of** ***p*** **and** ***q***  
**Option 3.1. Interpret ACF and PACF Plots**  
> **3.1.1. Compare with the Significance Range**
> [**Model 1. SARIMA (4,1,4) x (0,1,0,4)**]()  
- **ACF and PACF of Model 1's Residuals**  

<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/P_3_1_1_M1ResidualAcfPacf.png"/></div>

- **Coefficients and Standard Errors of Model 1**
<br>
<div align=center><img src="https://github.com/lclh813/Time_Series_Analysis/blob/master/P_3_1_2_M1CoefficientSe.png"/></div>
<br>

**3.1.2. Determine the Coefficients of the Model**


## Part 5. Reference
- [NTHU STAT 5410 - Linear Models](http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php)
  - by ***Shao-Wei Cheng***, Institute of Statistics, National Tsing Hua University
- [Time Series Analysis: Univariate and Multivariate Methods](https://www.amazon.com/Time-Analysis-Univariate-Multivariate-Methods/dp/0321322169) 
  - by ***William W.S. Wei***
- [A Guide to Time Series Forecasting with ARIMA in Python 3](https://www.digitalocean.com/community/tutorials/a-guide-to-time-series-forecasting-with-arima-in-python-3)
  - by ***Thomas Vincent***
- [R Documentation](https://www.rdocumentation.org/)
- [Wikipedia](https://www.wikipedia.org/)

