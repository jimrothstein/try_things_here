## 061_simple_regression_cars.R

## http://r-statistics.co/Linear-Regression.html

library(tidyverse)
head(cars)

g<- cars %>%
	ggplot(aes(x=speed,y=dist)) 

g+	geom_point()

##	FIX	
##	note:   must set x="" or error
g + geom_boxplot(aes(x="",y=dist ))

 
boxplot(cars$dist)
boxplot(cars$speed)

## normal?
g + stat_bin(binwidth=2.5)
g + stat_bin(aes(x=dist), binwidth=10)


## cor, 0.807
cor(cars$speed,cars$dist)
