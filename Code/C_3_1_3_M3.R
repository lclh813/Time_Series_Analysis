#### Step 3. Estimate the Orders of p and q ####
#### Option 3.1. Interpret ACF and PACF Plots ####
#### 3.1.3. Grid Search ####
# Use a grid search to iteratively explore different combinations of parameters p and q.
# Based on the detection of 3.1.1., the highest orders of p and q should be set as 4.  

# Method 1.
for (p in c(0:4)) {
  for (q in c(0:4)) {
    m3 <- arima(Yt, order=c(p,1,q), seasonal = list(order=c(0,1,0),period=4))
    a <- round(m3$aic,digits = 3)
    b <- round(BIC(m3),digits = 3)
    cat("p=", p, "q=", q ,"AIC = ", a,"BIC = ", b,"\n")
  }}

# Method 2. 
# Create vector a and b for aic and BIC respectively to contain returned values.
a <- b <- c()
for (p in c(0:4)) {
  for (q in c(0:4)) {
    m3 <- arima(Yt, order=c(p,1,q), seasonal = list(order=c(0,1,0),period=4))
    a[(q+1)+5*p] <- round(m3$aic,digits = 3)
    b[(q+1)+5*p] <- round(BIC(m3),digits = 3)
  }}
# Specify which element in vector a has the minimum aic value.
which(a == min(aic))
# Specify which element in vector b has the minimum BIC value.
which(b == min(Bic))