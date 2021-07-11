#031_Prabhakaran_linear_regression.R

# too terse?

# see http://r-statistics.co/Linear-Regression.html
rm(list=ls())
library(tidyverse)
library(reprex)

# ---- 001_scatterplot ----
# Prab:
scatter.smooth(x=cars$speed, y=cars$dist, main="Dist ~ Speed")  # scatterplo

# in ggplot
library(tidyverse)
g <- ggplot(cars, aes(x=speed,y=dist))
g + geom_point()

g + geom_point() + geom_smooth()

geom_p
# ---- 002_outliers ----

# check for outliers:
# Prab:
par(mfrow=c(1, 2))  # divide graph area in 2 columns
boxplot(cars$speed, main="Speed", sub=paste("Outlier rows: ", boxplot.stats(cars$speed)$out))  # box plot for 'speed'
boxplot(cars$dist, main="Distance", sub=paste("Outlier rows: ", boxplot.stats(cars$dist)$out))  # box plot for 'distance'

# in ggplot, YES, Distance has outlier
# TODO(jim, combine in 1 stat_boxp
g <- ggplot(cars)  # default, boxplot expected group, just set x=""
g + stat_boxplot(aes(x="", y=speed)) +
        coord_cartesian(ylim=c(0,35)) # last is optional, but helpful

g + stat_boxplot(aes(x="", y=dist)) +
        coord_cartesian(ylim=c(0,130))

# 
sd(cars$dist)  #26
( cars$dist/sd(cars$dist))   # couple >3 sd     

# ---- 003-density, normal? ----
# TODO(jim, plot geom_density ?)
g <- ggplot(cars) 
g + geom_density(aes(x=dist), fill="lightblue") + ylab("frequency")
g + geom_density(aes(x=speed))
ggplot(diamonds, aes(carat, ..count.., fill = cut)) +
        geom_density(position = "stack")


# ---- 004-correlation ----
# TODO(jim, cor formula?)
cor(cars$speed, cars$dist)  #0.81  (high)

# ---- 005-linear model ----
linearMod <- lm(dist ~ speed, data=cars) # B0= -17.6, B1=3.9
g <- ggplot(cars, aes(x=speed, y=dist)) 
g + geom_point() + geom_smooth(method="lm")

# ---- 006-lm, diagnostics, significant? ----
summary(linearMod)


# Call:
#         lm(formula = dist ~ speed, data = cars)
# 
# Residuals:
#         Min      1Q  Median      3Q     Max 
# -29.069  -9.525  -2.272   9.215  43.201 
# 
# Coefficients:
#         Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
#         speed         3.9324     0.4155   9.464 1.49e-12 ***
#         ---
#         Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 15.38 on 48 degrees of freedom
# Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
# F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12
# ---- 007 p-value ----
linearMod
