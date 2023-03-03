#
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
dim(iris)
# [1] 150   5

# GOAL:   extract only the dataframes
d = list(
  list(
    list(
      iris[sample(1:150,3),],
      iris[sample(1:150,3),]
    ),
    list(
      list(
        iris[sample(1:150,3),],
        list(
          iris[sample(1:150,3),],
          iris[sample(1:150,3),]
        )
      )
    )
  )
)

jsonedit(d)
str(d)

# ------------------------------
#
#
res  <- rrapply(d,
  classes="data.frame",
  #f=identity,
  how= "flatten"
  )

res
##  list of 5 data.frame
str(res, list.len=3)
