
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


