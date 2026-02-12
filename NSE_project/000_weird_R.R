# 000_weird_R.R
#  see CalyPoly prof talk 

# Easy to screw up class !

#------------------------ normal  
mtcars
mod   <- lm( mpg ~ wt, mtcars)
summary(mod)
#------------------------  

# Note:
class(mod)   # lm

#------------------------ easy to cause trouble
# But, if define a new class ("jim") and define new summary() for jim class, poof!  
class(mod) <- "jim"

summary.jim  <- function(x) print("Hi from jim")
summary(mod)   # Hi from jim
#------------------------  

