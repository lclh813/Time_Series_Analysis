#### Step 2. Identfy the Order of d
#### Step 2.1. Ordinary Differencing
# Take a simple first difference of the transformed series.
dYt <- diff(Yt)
# Examine ACF and PACF after ordinary differencing.
acf(dYt,lag=20); pacf(dYt,lag=20)