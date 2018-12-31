#### Step 3. Estimate the Orders of p and q ####
#### Option 3.3. Automatic ARIMA Modelling ####
m5 <- auto.arima(dYt_s)
# Examine ACF and PACF of Model 4's residuals.
acf(m5$residuals,lag=20); pacf(m5$residuals,lag=20)
# Examine Model 5's coefficients and standard errors.
m5