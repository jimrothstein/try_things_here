# 050_simulate_die_roll.R

library(tidyverse)
library(purrr)

N  <- 10000
roll <- sample(x=c(-1,1),size=N,replace=TRUE, prob=c(0.5,0.5))
roll  <- as.integer(roll)
is_integer(roll)
is_vector(roll)# T
is_atomic(roll)
str(roll)


t  <- tibble(raw =roll,
	     cum_total = cumsum(raw))
print(t, n=20)
tail(t)

plot( x=1:N, y=t$cum_total)

