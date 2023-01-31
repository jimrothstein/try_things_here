## ------------------------
##    Only best examples
## ------------------------
#
library(data.table)

dt  <- data.table(mtcars)


##  
##  Generate arbitrary number of duplicate rows based upon value in col 
##

dt[
   ,  list(1:5)
   ,  by = "cyl"]




dt[
   ,  list(seq_len(cyl))
   ,  by = "cyl"]
