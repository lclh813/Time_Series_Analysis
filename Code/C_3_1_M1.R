#### Step 3. Estimate the Orders of p and q ####
#### Option 3.1. Interpret ACF and PACF Plots ####
#### 3.1.1. Compare with the Significance Range ####
# Model 1. SARIMA (4,1,4) x (0,1,0,4)
m1 <- arima(Yt, order=c(4,1,4),seasonal=list(order=c(0, 1, 0),period=4))
# Examine ACF and PACF of Model 1's residuals.
acf(m1$residuals,lag=20); pacf(m1$residuals,lag=20)
# Examine Model 1's coefficients and standard errors.
m1