## 062_simple_regression.R

## http://www.real-statistics.com/regression/least-squares-method/

library(tidyverse)
cig <- c(5,23,25,48,17,8,4,26,11,19,14,35,29,4,23)
yrs <- c(80,78,60,53,85,84,73,79,81,75,68,72,58,92,65)

t <- tibble(cig, yrs)

g<- t %>%
	ggplot(aes(cig,yrs))

g + geom_point()


model <- lm (yrs ~ cig)

## all 3 work same
g + geom_point() +geom_abline(intercept=85.7, slope=-0.63)
g + geom_point() +geom_abline(intercept=coef(model)[1], slope=coef(model)[2])
g + geom_point() +geom_abline(aes(intercept=coef(model)[1], 
								  slope=coef(model)[2]))
##
#	predictions
##
pred <- coef(model)[1] + coef(model)[2]*cig
