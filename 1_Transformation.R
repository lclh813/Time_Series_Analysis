# Import dataset.
data <- read.table("G:\\Data.csv")
Zt <- data$V1

require(forecast)
# Calculate the exponent and round down to the 2nd digit.
lambda <- round(BoxCox.lambda(Zt),digits=2)
# Apply variance stabilizing transformation.
Zt_trans <- Zt^(lambda)

# Plot
par(mfrow=c(1,2))
ts.plot(Zt); ts.plot(Zt_trans)