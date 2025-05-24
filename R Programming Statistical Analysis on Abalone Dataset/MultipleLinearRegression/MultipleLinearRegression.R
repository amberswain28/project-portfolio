library(readr)
library(glmnet)


abalone <- read_csv("abalone.csv")


#Number 1
ShuckedWeight <- lm(`Shucked weight` ~ Sex + Length + Diameter + Height + `Whole weight` + `Viscera weight` + `Shell weight` + Rings, data = abalone)
AdjustedRsquared <- summary(ShuckedWeight)$adj.r.squared
print(ShuckedWeight)
print(paste("Adjusted R-squared:", AdjustedRsquared))


#Number 2

#Testing Sex
NoSex <- lm(`Shucked weight` ~ Length + Diameter + Height + `Whole weight` + `Viscera weight` + `Shell weight` + Rings, data = abalone)
print(NoSex)
NoSexRsquared <- summary(NoSex)$adj.r.squared
print(paste("Adjusted R-squared:", AdjustedRsquared, " Adjusted R-squared Without Sex:", NoSexRsquared))


#Testing Length
NoLength <- lm(`Shucked weight` ~ Sex + Diameter + Height + `Whole weight` + `Viscera weight` + `Shell weight` + Rings, data = abalone)
NoLengthRsquared <- summary(NoLength)$adj.r.squared
print(paste("Adjusted R-squared:", AdjustedRsquared, " Adjusted R-squared Without Length:", NoLengthRsquared))

#Testing Diameter
NoDiameter <- lm(`Shucked weight` ~ Sex + Length + Height + `Whole weight` + `Viscera weight` + `Shell weight` + Rings, data = abalone)
NoDiameterRsquared <- summary(NoDiameter)$adj.r.squared
print(paste("Adjusted R-squared:", AdjustedRsquared, " Adjusted R-squared Without Diameter:", NoDiameterRsquared))


#Testing Height
NoHeight <- lm(`Shucked weight` ~ Sex + Length + Diameter + `Whole weight` + `Viscera weight` + `Shell weight` + Rings, data = abalone)
NoHeightRsquared <- summary(NoHeight)$adj.r.squared
print(paste("Adjusted R-squared:", AdjustedRsquared, " Adjusted R-squared Without Height:", NoHeightRsquared))


#Testing Whole Weight
NoWhole <- lm(`Shucked weight` ~ Sex + Length + Diameter + Height + `Viscera weight` + `Shell weight` + Rings, data = abalone)
NoWholeRsquared <- summary(NoWhole)$adj.r.squared
print(paste("Adjusted R-squared:", AdjustedRsquared, " Adjusted R-squared Without Whole Weight:", NoWholeRsquared))


#Testing Viscera Weight
NoV <- lm(`Shucked weight` ~ Sex + Length + Diameter + Height + `Whole weight` + `Shell weight` + Rings, data = abalone)
NoVRsquared <- summary(NoV)$adj.r.squared
print(paste("Adjusted R-squared:", AdjustedRsquared, " Adjusted R-squared Without V Weight:", NoVRsquared))

#Testing Shell Weight
NoShell <- lm(`Shucked weight` ~ Sex + Length + Diameter + Height + `Whole weight` + `Viscera weight` + Rings, data = abalone)
NoShellRsquared <- summary(NoShell)$adj.r.squared
print(paste("Adjusted R-squared:", AdjustedRsquared, " Adjusted R-squared Without S Weight:", NoShellRsquared))


#Testing Rings
NoR <- lm(`Shucked weight` ~ Sex + Length + Diameter + Height + `Whole weight` + `Viscera weight` + `Shell weight`, data = abalone)
NoRRsquared <- summary(NoR)$adj.r.squared
print(paste("Adjusted R-squared:", AdjustedRsquared, " Adjusted R-squared Without Rings:", NoRRsquared))



w1 <- lm(`Shucked weight` ~ Sex + Length + Diameter + `Whole weight` + `Viscera weight` + `Shell weight` + Rings, data = abalone)
NoHeightRsquared <- summary(w1)$adj.r.squared
print(NoHeightRsquared)
coefficients(w1)


#Number 3 Lasso

x <- data.matrix(abalone[, c('Sex', 'Length', 'Diameter', 'Height', 'Whole weight', 'Viscera weight', 'Shell weight', 'Rings')])
y <- abalone$`Shucked weight`

cv_model <- cv.glmnet(x, y, alpha = 1)
best_lambda <- cv_model$lambda.min

plot(cv_model)

best_model <- glmnet(x, y, alpha = 1, lambda = best_lambda)
coef(best_model)

predict(best_model, newx = x)


#Number 5
w1_summary <- summary(w1)
w2_summary <- summary(best_model)

mean(w1_summary$residuals^2)
mean((abalone$`Shucked weight` - predict(best_model, newx = x))^2)

#Number 6

res <- ShuckedWeight$residuals
plot(fitted(ShuckedWeight), res)
abline(0,0)


# w* residuals
plot(abalone$`Shucked weight`, resid(ShuckedWeight), ylab = "Residuals", xlab = "Shucked Weight", pch = "*", col = 'darkblue', main = "Residuals of w*")
x <- seq(0, 1, length = 100 )
abline(x, 0*x, lwd=3, col = "green")

# w1* residuals 
plot(abalone$`Shucked weight`, resid(w1), ylab = "Residuals", xlab = "Shucked Weight", pch = "*", col = 'darkblue', main = "Residuals of w1*")
x <- seq(0, 1, length = 100 )
abline(x, 0*x, lwd=3, col = "green")

# w2* residuals
x <- as.matrix(abalone[, c('Length', 'Diameter', 'Height', 'Whole weight', 'Viscera weight', 'Shell weight', 'Rings')])
y <- as.numeric(abalone$`Shucked weight`)
lasso_model_w2 <- glmnet(x, y, alpha = 1, lambda = best_lambda)

fitted_values <- predict(lasso_model_w2, newx = x)
residuals <- y - fitted_values

# Plot the residuals against the fitted values
plot(fitted_values, residuals, ylab = "Residuals", xlab = "Shucked Weight", pch = "*", col = 'darkblue', main = "Residuals of w2*")
abline(h = 0, lwd=3, col = "green") 