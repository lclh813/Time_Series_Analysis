#### Step 2. Identfy the Order of d ####
#### Step 2.2. Seasonal Differencing ####
# Take a seasonal first difference of the differenced series
# with regular intervals being set as 4.
dYt_s <- diff(dYt,4,1)
# Examine ACF and PACF after seasonal differencing.
# Extend lag lengths to better observe the seasonal trend.
acf(dYt_s,lag=35); pacf(dYt_s,lag=35)