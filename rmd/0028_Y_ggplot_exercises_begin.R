# 028_r_exercises_begin.R

# see
# http://www.r-exercises.com/2017/07/01/hacking-statistics-exercises-part-1/

library(tidyverse)
# ---- Exercise 1 ----

set.seed(1492)
n <- 500
df <- data.frame(x=rnorm(n))
ggplot(df, aes(x)) + geom_histogram()

exer <- function(n){
        df <- data.frame(x=rnorm(n))
        ggplot(df, aes(x)) + geom_histogram()
}

exer(1000)

# ---- Exercise 3 ----
# dnorm
x <- seq(-3,3,.05)
dg <- data.frame(x=x, y=dnorm(x) )
ggplot(dg, aes(x=x, y=y)) + geom_line(color="blue")
        
# combine:
combine <- function(n=500){
 x <- seq(-3,3,.05)
 dg <- data.frame(x=x, y=dnorm(x) )
 df <- data.frame(x=rnorm(n))
g<- ggplot(df, aes(x=x,y= ..density..))  + 
        geom_histogram(alpha=0.5, fill='green')
g + geom_line(data=dg, mapping=aes(x=x, y=y), color="blue")

}
combine(1000)
combine(10000)
