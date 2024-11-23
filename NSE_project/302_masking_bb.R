# for package b


##  AFTER running
##  a will be same as aa.R, EXCEPT its c() is version here!
##  b will as defined here
##  c will as defined here

##  We have lost original b(), c()  and a(), not changed, but its c() refers one here.

# did you run aa.R?
stopifnot(exists("a") && exists("b") && exists("c"))

c <- function() "Hello from package b!"
b <- function() paste("B+", c())
if (FALSE) source("R/aa.R")
