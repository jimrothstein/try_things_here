
---
title: "089_lapply_sapply.R"
output:  
  pdf_document:
geometry: "left=2cm,right=2cm,top=2cm,bottom=2cm"
fontsize: 12pt
---

```
# v is list
v <- list(1:5, rnorm(10))

# mean
lapply(v, mean) # return list

# sapply is 'smarter', see scalers and returns vector[] instead.
sapply(v, mean) # return vector!

# ?
l <- list(a=1:5, b=6:10)

sapply(l, `[`)

#-----------------
# runif | runif(n) returns double[] n values from uniform distr
# ---------

# to check
args(runif)

runif(3)

lapply(1:4,runif) # treats 1:4 as list, retuns list
```

#  #####
#  integer(1) creates 0
#  integer(2)         0 0
#
n  <- 10^6

## atomic int[]  fastest?
##
# create int[] of length n, filled with 1:n
if (FALSE )
  seq_len(n)

# fills x 1:n
x  <- vapply(seq_len(n), function(i) {i}, integer(1))
head(x)

x  <- NULL


# creates all zeroes
x  <- vapply(seq_len(n), function(i) {integer(1)}, integer(1))
head(x)




