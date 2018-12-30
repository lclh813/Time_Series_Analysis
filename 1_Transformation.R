data <- read.table("G:\\Data.csv")
Zt <- data$V1

require(forecast)
lambda <- round(BoxCox.lambda(Zt),digits=2)
Zt_trans <- Zt^(lambda)