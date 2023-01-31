
---
title: "`r knitr::current_input()`"
date: "`r paste('last updated', 
    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: show
        toc: true 
        toc_depth: 4
        toc_float: true
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  4   
fontsize: 11pt   
geometry: margin=0.4in,top=0.25in   
TAGS:  regression, linear algebra,
---
~/code/MASTER_INDEX.md
file="/home/jim/.config/nvim/templates/skeleton.R"

# ==========================================
####  BASIC Linear Algebra (see Shaina...)
###   Ch 4
###   https://shainarace.github.io/LinearAlgebra/intro.html
# ==========================================
#
# R
#
#
X  <- matrix(rnorm(4), nrow=2)
X

## transpose
    t(X)

## vector all 1
    one  <- rep(1, 5)
    one

##  2 column matrix
    A  <- replicate(2, rnorm(n=10))
    A
    dim(A)

##  take mean, tricky: note arg names, MARGIN=2 (columns)
    apply(A, MARGIN=2, FUN="mean")
    apply(A, MARGIN=2, FUN=sd)
    #apply(A, MARGIN=2, FUN=colMeans)
    #
##  Center 
    B  <- apply(A, MARGIN=2, FUN=function(x) x-mean(x))
    B
    colMeans(B)

##  "Zero"
    zero  <- .Machine$double.eps
    colMeans(B) < zero
    
##  inverse of X
    X
    invX  <- solve(X)
    invX
    X %*% invX
    invX %*% X

##  norm of vector/matrix(?)
    one
    norm(one, type="2")

##  sqrt X %*% X
    sqrt(X %*% X)
    
