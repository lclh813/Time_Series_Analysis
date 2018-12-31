#### Step 3. Estimate the Orders of p and q ####
#### Option 3.2. Compute ESACF ####
# Identify the vertex of the zero triangle is at (1,4) position.
eacf(dYt_s,ar.max=15, ma.max=15)
m4 <- arima(Yt, order=c(1,1,4),seasonal=list(order=c(0,1,0),period=4))
# Examine ACF and PACF of Model 4's residuals.
acf(m4$residuals,lag=20); pacf(m4$residuals,lag=20)
# Examine Model 4's coefficients and standard errors.
m4