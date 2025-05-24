library(readr)
abalone <- read_csv("abalone.csv")


# part a scatterplots and correlation coefficients
plot(abalone$Length, abalone$`Shucked weight`, col = "blue", pch = "*",
           xlab = "Length\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
           main = "Shucked Weight vs Length")

cor(abalone$`Shucked weight`, abalone$Length)

plot(abalone$`Whole weight`, abalone$`Shucked weight`, col = "purple", pch = "*",
     xlab = "Whole Weight\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "Shucked Weight vs Whole Weight")

cor(abalone$`Shucked weight`, abalone$`Whole weight`)

plot(abalone$Height, abalone$`Shucked weight`, col = "brown", pch = "*",
     xlab = "Height\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "Shucked Weight vs Height")

cor(abalone$`Shucked weight`, abalone$Height)

plot(abalone$Diameter, abalone$`Shucked weight`, col = "red", pch = "*",
     xlab = "Diameter\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "Shucked Weight vs Diameter")

cor(abalone$`Shucked weight`, abalone$Diameter)

plot(abalone$`Viscera weight`, abalone$`Shucked weight`, col = "green", pch = "*",
     xlab = "Viscera Weight\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "Shucked Weight vs Viscera Weight")

cor(abalone$`Shucked weight`, abalone$`Viscera weight`)


plot(abalone$`Shell weight`, abalone$`Shucked weight`, col = "pink", pch = "*",
     xlab = "Shell Weight\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "Shucked Weight vs Shell Weight")

cor(abalone$`Shucked weight`, abalone$`Shell weight`)


#part b
#shucked weight vs length linear regression line on scatterplot
line1 <- lm(abalone$`Shucked weight` ~ abalone$Length)
print(line1)
plot(abalone$Length, abalone$`Shucked weight`, col = "darkblue", pch = "*",
     xlab = "Length\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "LSRL of Shucked Weight vs Length")
abline(line1, lwd=3, col = "green")
#residuals for length
plot(abalone$Length, resid(line1), ylab = "Residuals", xlab = "Length\n(Explanatory Variable)", pch = "*",
     col = 'darkblue', main = "Residuals of Abalone Length")

x <- seq(0, 1, length = 100 )
abline(x, 0*x, lwd=3, col = "green")


#shucked weight vs Whole Weight linear regression line on scatterplot
line2 <- lm(abalone$`Shucked weight` ~ abalone$`Whole weight`)
print(line2)
plot(abalone$`Whole weight`, abalone$`Shucked weight`, col = "purple", pch = "*",
     xlab = "Whole Weight\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "LSRL of Shucked Weight vs Whole Weight")
abline(line2, lwd=3, col = "black")
#residuals for Whole Weight
plot(abalone$`Whole weight`, resid(line2), ylab = "Residuals", xlab = "Whole Weight\n(Explanatory Variable)", pch = "*",
     col = 'purple', main = "Residuals of Abalone Whole Weight")
x <- seq(0, 1, length = 100 )
abline(x, 0*x, lwd=3, col = "black")

#shucked weight vs Height linear regression line on scatterplot
line3 <- lm(abalone$`Shucked weight` ~ abalone$Height)
print(line3)
plot(abalone$Height, abalone$`Shucked weight`, col = "brown", pch = "*",
     xlab = "Height\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "LSRL of Shucked Weight vs Height")
abline(line3, lwd=3, col = "blue")
#residuals for Height
plot(abalone$Height, resid(line3), ylab = "Residuals", xlab = "Height\n(Explanatory Variable)", pch = "*",
     col = 'brown', main = "Residuals of Abalone Height")
x <- seq(0, 1, length = 100 )
abline(x, 0*x, lwd=3, col = "blue")


#shucked weight vs diameter linear regression line on scatterplot
line4 <- lm(abalone$`Shucked weight` ~ abalone$Diameter)
print(line4)
plot(abalone$Diameter, abalone$`Shucked weight`, col = "red", pch = "*",
     xlab = "Diameter\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "LSRL of Shucked Weight vs Diameter")
abline(line4, lwd=3, col = "darkblue")
#residuals for Diameter
plot(abalone$Diameter, resid(line4), ylab = "Residuals", xlab = "Diameter\n(Explanatory Variable)", pch = "*",
     col = 'red', main = "Residuals of Abalone Diameter")
x <- seq(0, 1, length = 100 )
abline(x, 0*x, lwd=3, col = "darkblue")

#shucked weight vs Viscera Weight linear regression line on scatterplot
line5 <- lm(abalone$`Shucked weight` ~ abalone$`Viscera weight`)
print(line5)
plot(abalone$`Viscera weight`, abalone$`Shucked weight`, col = "darkgreen", pch = "*",
     xlab = "Viscera Weight\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "LSRL of Shucked Weight vs Viscera Weight")
abline(line5, lwd=3, col = "darkorange")
#residuals for Viscera Weight
plot(abalone$`Viscera weight`, resid(line5), ylab = "Residuals", xlab = "Viscera Weight\n(Explanatory Variable)", pch = "*",
     col = 'darkgreen', main = "Residuals of Abalone Viscera Weight")
x <- seq(0, 1, length = 100 )
abline(x, 0*x, lwd=3, col = "darkorange")

#shucked weight vs Shell Weight linear regression line on scatterplot
line6 <- lm(abalone$`Shucked weight` ~ abalone$`Shell weight`)
print(line6)
plot(abalone$`Shell weight`, abalone$`Shucked weight`, col = "pink", pch = "*",
     xlab = "Shell Weight\n (Explanatory Variable)", ylab= "Shucked Weight(Response Variable)",
     main = "LSRL of Shucked Weight vs Shell Weight")
abline(line6, lwd=3, col = "darkblue")
#residuals for Viscera Weight
plot(abalone$`Shell weight`, resid(line6), ylab = "Residuals", xlab = "Shell Weight\n(Explanatory Variable)", pch = "*",
     col = 'pink', main = "Residuals of Abalone Shell Weight")
x <- seq(0, 1, length = 100 )
abline(x, 0*x, lwd=3, col = "darkblue")


#part d
WholeWeight <- lm(abalone$`Shucked weight` ~ abalone$`Whole weight`)
summary(WholeWeight)
confint(WholeWeight)
##Output from summary
# Call:
#   lm(formula = abalone$`Shucked weight` ~ abalone$`Whole weight`)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.32282 -0.02122  0.00098  0.02363  0.45298 
# 
# Coefficients:
#                         Estimate Std. Error   t value   Pr(>|t|)    
# (Intercept)            -0.004267   0.001656  -2.577     0.01 *  
#   abalone$`Whole weight`  0.438778   0.001719 255.179   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.05449 on 4175 degrees of freedom
# Multiple R-squared:  0.9397,	Adjusted R-squared:  0.9397 
# F-statistic: 6.512e+04 on 1 and 4175 DF,  p-value: < 2.2e-16


WholeWeight <- lm(abalone$`Shucked weight` ~ abalone$`Whole weight`)
summary(WholeWeight)
confint(WholeWeight)

ShellWeight <- lm(abalone$`Shucked weight` ~ abalone$`Shell weight`)
summary(ShellWeight)
confint(ShellWeight)
##Output from Summary
# Call:
#   lm(formula = abalone$`Shucked weight` ~ abalone$`Shell weight`)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.78764 -0.04563 -0.01326  0.04726  0.64004 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)            0.023246   0.003207   7.249 4.97e-13 ***
#   abalone$`Shell weight` 1.407360   0.011601 121.316  < 2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.1044 on 4175 degrees of freedom
# Multiple R-squared:  0.779,	Adjusted R-squared:  0.779 
# F-statistic: 1.472e+04 on 1 and 4175 DF,  p-value: < 2.2e-16


#part e
summary(abalone$`Whole weight`)
WholeWeight <- lm(abalone$`Shucked weight` ~ abalone$`Whole weight`)


# error thatI got form running this line
# Error: unexpected '=' in "predict(WholeWeight, data.frame(abalone$`Whole weight` ="
predict(WholeWeight, data.frame(abalone$`Whole weight` =  c(0.4415),interval = "confidence"))


#this one changed all of the row values to 0.4415 but ran
predict(WholeWeight, data.frame(abalone$`Whole weight` <- 0.4415),interval = "confidence")


summary(abalone$`Shell weight`)
#Q1 = 0.1300
ShellWeight <- lm(abalone$`Shucked weight` ~ abalone$`Shell weight`)
#gave me predicted values for every row in the data set
predict(ShellWeight, interval = "confidence")
predict(ShellWeight, data.frame(ShellWeight = 0.1300), interval = "confidence")
predict(ShellWeight, data.frame(abalone$`Shell weight` <- 0.1300), interval = "confidence")
