file <- "43_rrapply_example.R#"
##  Compare to base::rapply
##  PURPOSE:  !so 47603578; extract data.frames as list from nested structure
##
library(rrapply)
library(listviewer)
data(package = "rrapply")


##  give.attr=F (cleaner)
##  list.len=3
##  max.level = 
##  
# ------------------------------
# FAKE structure
# ------------------------------
create_X  <- function() { 
X  <- structure(list(a=c(1,2,3),
                     b=c(4,5,6)),
                class = "myclass")

# add 2nd
attr(X, "attr_two")  <- "hello"
return(X)

}
X  <- create_X()
str(X)
# List of 2
#  $ a: num [1:3] 1 2 3
#  $ b: num [1:3] 4 5 6
#  - attr(*, "class")= chr "myclass"
#  - attr(*, "attr_two")= chr "hello"
# NULL


# ------------------------------
# GOAL:   Drop $b, but otherwise keep structure
# ------------------------------
# ------------------------------
# 1) BASE
# ------------------------------
replace(X, 2, NULL)
str(replace(X, 2, NULL))
# List of 1
#  $ a: num [1:3] 1 2 3
#  - attr(*, "class")= chr "myclass"
#  - attr(*, "attr_two")= chr "hello"
# NULL
#
# ------------------------------
# 2) use NULL
# ------------------------------
X[[2]]  <- NULL
X
str(X)
# List of 2
#  $ a: num [1:3] 1 2 3
#  $ b: num [1:3] 4 5 6
#  - attr(*, "class")= chr "myclass"
#  - attr(*, "attr_two")= chr "hello"
# NULL
#  $ :List of 2
#   ..$ : num 1
#   ..$ : num 2
# NULL
# ------------------------------
# 3) use rrapply
# ------------------------------
# toupper
X  <- create_X()
rrapply(X, 
        how="names",
        f= \(x, .xname) toupper(.xname)
  )


names(X)[-2]  # from right, drop
# [1] "a"
#
rrapply(X, 
        #condition = function(x, .xname, .xpos)  .xname %in% names(X)[-2] && .xpos == 1,  
        condition = function(x, .xname, .xpos)  .xpos == 1,  
        f = identity, 
        how="prune")

