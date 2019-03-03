#### Preparation ####
# Import library.
library(forecast)
library(TSA)
library(tseries)

# Import data.
data <- read.table("G:\\data.txt", header=TRUE)
head(data)

# Split data into training and validation sets.
Zt <- data$Rev[-c(73:76)]
head(Zt)

#### Step 1. Choose Proper Transformations ####
lambda <- BoxCox.lambda(Zt,method = "guerrero")
#lambda <- BoxCox.lambda(Zt, method="loglik")
lambda

# Data transformation
Yt <- (Zt)^(lambda)

# Plot Zt and Yt.
par(mfrow=c(1,2))
ts.plot(Zt); ts.plot(Yt)

# Plot ACF and PACF of Yt.
par(mfrow=c(1,2))
acf(Yt, lag=25); pacf(Yt, lag=25) 

#### Step 2. Identfy the Order of d ####
#### Step 2.1. Ordinary Differencing ####
dYt <- diff(Yt)
acf(dYt, lag=25); pacf(dYt, lag=25)

#### Step 2.2. Seasonal Differencing ####
# Seasonal pattern observation: 12 groups
time1 <- c(rep(1:12,6))
par(mfrow=c(1,1))
monthplot(Yt, phase=time1, xlab="month", ylab="Yt")

# Seasonal pattern observation: 3 groups
time2 <- c(rep(rep(c(1:3), each=4),6))
par(mfrow=c(1,1))
monthplot(Yt, phase=time2, ylab="Yt")

# Seasonal Differencing
dYt_s <- diff(dYt,4,1)
par(mfrow=c(1,2))
acf(dYt_s, lag=25); pacf(dYt_s, lag=25)

#### Step 3. Estimate the Orders of p and q ####
#### Option 3.1. Interpret ACF and PACF Plots ####
#### 3.1.1. Compare with the Significance Range ####
#### Model 0. (4,1,5) x (0,1,0)_4 ####
m0 <- arima(Yt, order=c(4,1,5),
            seasonal=list(order=c(0,1,0), period=4))
m0

#### Model 1. (4,1,4) x (0,1,0)_4 ####
m1 <- arima(Yt, order=c(4,1,4),
            seasonal=list(order=c(0,1,0), period=4))
m1
acf(m1$residuals, lag=20); pacf(m1$residuals, lag=20)

#### 3.1.2. Determine Coefficients of the Model ####
#### Model 2. (1,1,4) x (0,1,0)_4, MA(2)=MA(3)=0 ####
m2 <- arima(Yt, order=c(1,1,4), fixed=c(NA,NA,0,0,NA),
            seasonal=list(order=c(0,1,0), period=4))
m2
acf(m2$residuals, lag=20); pacf(m2$residuals, lag=20)

#### 3.1.3. Grid Search #### 
#### Model 3. (1,1,4) x (0,1,0)_4 ####
aic <- Bic <- c()
for (p in c(0:5)) {
  for (q in c(0:5)) {
    result <- arima(dYt_s, order=c(p,0,q))
    aic[p*6+(q+1)] <- result$aic
    Bic[p*6+(q+1)] <- BIC(result)
    cat("p=", p, "q=", q ,"AIC = ", aic[p*6+(q+1)],"BIC = ",Bic[p*6+(q+1)] ,"\n")
  }}
which(aic == min(aic))
which(Bic == min(Bic))

m3 <- arima(Yt, order=c(1,1,4),
            seasonal=list(order=c(0,1,0), period=4))
m3
acf(m3$residuals, lag=20); pacf(m3$residuals, lag=20)

#### Option 3.2. Compute ESACF ####
#### Model 4. (2,1,3) x (0,1,0)_4 ####
eacf(dYt_s, ar.max=16, ma.max=16)
m4 <- arima(Yt, order=c(2,1,3),
            seasonal=list(order=c(0,1,0), period=4))
m4
acf(m4$residuals,lag=20); pacf(m4$residuals,lag=20)

#### Option 3.3. Automatic ARIMA Modelling ####
#### Model 5. (1,1,0) x (0,1,0)_4 ####
auto.arima(dYt_s)

m5 <- arima(Yt, order=c(1,1,0),
            seasonal=list(order=c(0,1,0), period=4))
m5
acf(m4$residuals,lag=20); pacf(m4$residuals,lag=20)

#### Step 4. Model Selection #### 
#### Option 4.1. Create table T1 to facilitate the comparison of AIC and BIC.####
# byrow: To fill the matrix by row.
T1 <- data.frame(matrix(c(BIC(m1),BIC(m2),BIC(m3),BIC(m4),BIC(m5),
                          m1$aic,m2$aic,m3$aic,m4$aic,m5$aic),
                          ncol=5, nrow=2, byrow=T))
colnames(T1)=c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5")
rownames(T1)=c("BIC", "AIC")
T1

#### Option 4.2. Create table T2 to rank AIC and BIC in ascending order. ####
a1 <- rank(c(BIC(m1),BIC(m2),BIC(m3),BIC(m4),BIC(m5)))
a2 <- rank(c(m1$aic,m2$aic,m3$aic,m4$aic,m5$aic))
# Combine dataframes by row.
T2 <- data.frame(rbind(a1,a2))
colnames(T2)=c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5")
rownames(T2)=c("BIC Rank","AIC Rank")
T2

#### Step 5. Residual Analysis ####
#### step 5.1. Stationary Test ####
# To make sure the residuals are white noise.
#### Option 5.1.1. Interpret the plot ####
par(mfrow=c(1,1))
ts.plot(m2$residuals); abline(h=0, col=2)

#### Option 5.1.2. Augmented Dickey¡VFuller (ADF) Test ####
# Null hypothesis (H0): The series is "not" stationary.
# p-value = 0.01 suggesting that H0 can be rejected,
# namely the series is stationary.
adf.test(m2$residuals)

#### step 5.2. Normality Test ####
#### Option 5.2.1. Interpret the Plot ####
# Points are close to the 45-degree line, 
# which indicates that the series is normality distributed.
par(mfrow=c(1,1))
qqnorm(m2$residuals); qqline(m2$residuals, col=2)

#### Option 5.2.2. Shapiro Test ####
# Null hypothesis (H0): A set of observations is normally distributed.
# p-value = 0.02 suggesting that H0 can be rejected,
# namely the series is not normally distributed and therfore 
# the model is expected to have lower forecast accuracy. 
shapiro.test((m2$residuals))

#### Step 5.3. Autocorrelation Test ####
# Ljung-Box Q (LBQ) Test
# Null hypothesis (H0): Data values are independent up to lag k.
# p-values of lag 1 to lag 20 are above the line of 0.05, 
# which suggests that H0 cannot be rejected and 
# residuals are ¡§not¡¨ autocorrelated.
p1 <- rep(0,20)
for(i in 1:20){
  p1[i] <- Box.test(m2$residual, lag=i, type="Ljung")$p.value}
par(mfrow=c(1,1))
plot(p1, ylim=c(0,1), ylab="p", pch=3)
abline(h=0.05, col=2)

#### Step 6. Model Evaluation ####
#### Step 6.1. Training: Fit the model by using the training data ####
fit <- Arima(Yt, order=c(1,1,4), fixed=c(NA,NA,0,0,NA),
            seasonal=list(order=c(0,1,0), period=4))
future <- forecast(fit, h=4)
future

#### Step 6.2. Validation: Compare with the actual data ####
# Original data Zt transformed into Yt.
(data$Rev[c(73:76)])^(lambda)

# Plot 
par(mfrow = c(1,1))

# Training
plot(future, xlim=c(60,76))

# Validation
points(c(60:76), c(rep(0,13), (data$Rev[c(73:76)])^(lambda)), col="red")

#### Step 7. Prediction ####
# Prediction
pred_Yt <- forecast(fit, h=16)
pred_Yt

# Data transformation
print(class(pred_Yt))
print(typeof(pred_Yt))
pred_Yt[[4]][5:16]
pred_Zt <- pred_Yt[[4]][5:16]^(1/lambda)
pred_Zt

# Plot
par(mfrow = c(1,1))
ts.plot(data, xlim=c(1,88), ylim=c(1,50))
lines(77:88, pred_Zt, col=2)