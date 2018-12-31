#### Step 3. Estimate the Orders of p and q ####
#### Option 3.1. Interpret ACF and PACF Plots ####
#### 3.1.2. Determine the Coefficients of the Model ####
# Model 2. SARIMA (1,1,4) x (0,1,0,4) 
# with coefficients of MA(1), MA(2) and MA(3) being set as 0.
m2 <- arima(Yt, order=c(1,1,4),fixed= c(NA,0,0,0,NA),
            seasonal=list(order=c(0, 1, 0),period=4))
# Examine ACF and PACF of Model 2's residuals.
acf(m2$residuals,lag=20); pacf(m2$residuals,lag=20)
# Examine Model 2's coefficients and standard errors.
m2