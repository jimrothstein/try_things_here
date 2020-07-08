---
title: "091_matrix_examples.R"
output:  
  pdf_document:
geometry: "left=2cm,right=2cm,top=2cm,bottom=2cm"
fontsize: 12pt
---

```
## CREATE
# =========
m <- matrix(c(1,0,0,1), nrow=2, ncol=2, byrow=TRUE)
m

m[1]  # 1st element (vector)
m[c(1,4)] # 1st and last (vector)

m[,1] # 1st column (vector)
m[,1, drop =F] # matrix, 2x1

## TEST
# =======
is.matrix(m)

## Convert
# ==========
df  <- data.frame(x=c(1,0), y=c( 0,1))
df

m1  <- as.matrix(df)
m1

## Misc
# =======
dim(m)
nrow(m)
ncol(m)
mode(m)			# numeric

## DIAGONAL
# ===========
diag(nrow=7,ncol=7)

diag(c(2,1), nrow=2)

## matrix arithmetic
# ====================
m <- matrix(c(1,2,3,4), nrow=2, byrow=TRUE)
m
m + m

m * m 	# cell by cell

m %*% m # matrix muli

t(m)  # transpose

solve(m) # inerse

solve(m) %*% m    # hmmm, not so accurtate	

solve(m) %*% m == diag(nrow=nrow(m))   # cell-by-cell comparison

# Eigenvalues
# =============
eigen(m)
```
