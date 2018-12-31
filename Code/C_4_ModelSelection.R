#### Step 4. Model Selection ####
# Create a table for comparison.
t <- data.frame(matrix(c(BIC(m1),BIC(m2),BIC(m3),BIC(m4),m5$bic,
                         m1$aic,m2$aic,m3$aic,m4$aic,m5$aic),ncol=5,nrow=2))
# Define column names.
colnames(t)=c("Model 1","Model 2","Model 3","Model 4","Model 5")
# Define row names.
rownames(t)=c("BIC","AIC")
t