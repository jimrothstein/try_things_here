# file <- "45_rrapply_depth.R"
#   PURPOSE:   nesting level 
#   https://stackoverflow.com/questions/13432863/determine-level-of-nesting-in-r
#
library(rrapply)

##  give.attr=F (cleaner)
##  list.len=3
##  max.level = 
##  
##
# ----------------------------------------------------------
l1 <- list(1, 2, 3)
l2 <- list(1, 2, l1, 4)
l3 <- list(1, l1, l2, 5)

# ----------------------------------------------------------

# ----------------------------------------------------------
##  STUDY
  unlist(l1)
  unlist(l2)
  rrapply(l1, f = function(x, .xpos) .xpos, how = "unlist")
  rrapply(l1, f = function(x, .xpos) length(.xpos), how = "unlist")
# ----------------------------------------------------------

max(rrapply(l1, f = function(x, .xpos) length(.xpos), how = "unlist"))
#> [1] 1
max(rrapply(l2, f = function(x, .xpos) length(.xpos), how = "unlist"))
#> [1] 2
max(rrapply(l3, f = function(x, .xpos) length(.xpos), how = "unlist"))
#> [1] 

# ----------------------------------------------------------


