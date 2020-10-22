# 033_Lane_regression

# see:
# http://onlinestatbook.com/2/regression/regression.html
library(tidyverse)
# ---- A ----
x<- c(1,2,3,4,5)
y<- c(1,2,1.3,3.75,2.25)
t <- tibble(x=x,y=y)
g <- ggplot(t,aes(x=x,y=y)) 
g + geom_point()

# model
model <- lm(y ~ x, t)
B0 <- model$coefficients[[1]] # 0.785 (intercept)
B1 <- model$coefficients[[2]]

# plot regression line
g + geom_point() + geom_abline(slope = B1, intercept = B0)

# ---- check by 'manual' calc ----
m.x <- mean(x)
m.y <- mean(y)
sd.x <- sd(x)
sd.y <- sd(y)
r <- cor(x,y)# .627

#collect

v <- c(m.x, m.y, sd.x, sd.y, r)

# coeficients
b <- r*sd.y/sd.x  # 0.45  (slope)
a <- m.y - b*m.x  # 0.785 (intercept)

# Check:  if standard variables, z
# regression line becomes
# slope = r * Z
# intercept = 0

Z.x <-  (x- m.x)/sd.x
Z.y <-  (y - m.y)/sd.y

mean(Z.x)       # 0
mean(Z.y)       # ~ 0

sd(Z.x)         # 1
sd(Z.y)         # 1
r.Z <- cor(Z.x,Z.y) # 0.627 (no change)

b.Z <- r.Z * (sd(Z.x)/sd(Z.y))
a.Z  <- mean(Z.y) - b.Z *mean(Z.x)
b.Z # 0.627 (=r.Z)
a.Z # ~ 0
# ------------------------

# ---- GPA & SAT ----
# data: http://onlinestatbook.com/2/case_studies/data/sat.txt

# ---- partition sum of squares ----
m.y.hat <- mean(y.hat) # 2.06

mse <- sum((y.hat-y)**2)  # aka SSE
SSY.hat <- sum ( (y.hat-m.y.hat)**2 ) # 1.8065
SSY <- sum((y-m.y)**2)  # 4.597

# ---- ----
