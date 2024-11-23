---
title: "`r knitr::current_input()`"
date: "`r paste('last updated', 
    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: show
        toc: true 
        toc_depth: 2
        toc_float: true
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  2   
    fontsize: 11pt   
    geometry: margin=0.5in,top=0.25in   
TAGS: lapply,sapply,named,unamed,mapply, chatty
---


### Map(f, ...)

#### simple

{
    formals(Map)
# $f
# 
# 
# $...
# 
# 
 }
 {
    ## Map with 1 variable
    l  <- list(1:3, letters)
    Map(f = class, l)

####
    ## Map with 2 variables 
    l1  <- 1:3
    l2   <-  11:13
    f  <- function(x,y) x+y
    Map(f, l1, l2)
    unlist(Map(f, l1, l2))
# [1] 12 14 16
}

#### Map with df
 str(iris)
# 'data.frame':	150 obs. of  5 variables:
#  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
# NULL
 #
##  iris$Species is factor,  split into separate df based on this grouping
    l  <- split(iris, iris$Species)
    str(l)

## SAME
    Map(nrow, l)
    sapply(l, nrow)



## -----------------------------------------------------
#### Filter:  LEGACY, from advancedR  006_functions.R
###   Purpose:  select only certain elements of list
###   STUDY:  `LEGACY` source
## -----------------------------------------------------
##
# 1st unlist
l  <- list(a=c(10,20,30), b=c(TRUE,FALSE), c=c("hello", "bye"))

# return named chr[] vector
y  <- unlist(l)
names(y)
y

# 2nd code:
base::Filter
lapply


# return list
lapply(l, is.numeric)

# extracts only numeric, returns as atomic 
Filter(is.numeric, l)

# to see why, run Filter's code, step-by-step

    f  <-  function(x) is.numeric(x)
    unlist(lapply(l,f))# atomic, logical, plus names
    as.logical(unlist(lapply(l,f))) # atomic, logical vector, no names

ind  <- as.logical(unlist(lapply(l,f))) 
which(ind) # return index which are TRUE
# same as Filter:
l[which(ind)] # subset original list, see all atomic elemtns



#### Map(f, ...)
{
    l q 






}

#### base::mapply(.f, ..1, ..2, ...) is form of base:Map()
  *  Apply function to two or more list arguments, retrurn list
  *  Do not confuse with purrr::as_mapper etc, which take FUN, return new FUN.
```{r mapply}
f  <- function(x, y) {
    x + y 
}

g  <- function(.x, .y) {
    (.x + .y   )
}

mapply(f, list(1,2), list(10, 10))

mapply(g, list(1,2), list(10, 10))


mapply( ~ (..1 + ..2 + ..3))
mapply(list(1,2),list(0,0), FUN =     function(.x, .y)   (.x + .y))
mapply(list(1,2),list(0,0),list(0,0),  FUN =     function(.x, .y, .z)   (.x + .y + .z))
mapply(list(1,2),list(0,0),list(0,0),  FUN =     function(..1, .y, .z)   (..1 + .y + .z))


## purrr:: map is differnt, take a function and return a NEW function
{
  if (F) {
    purrr::map
    purrr::as_mapper
    rlang::as_function  
  }
}
```


Once we have names, use purrr to run against each step in code.
* use purrr to run names() against test collection
* use purrr to run is.list, has_names() against test collection

```{r nms}
x  <- list()
x  <- list(1,2)
x  <- list(a=1, b=2)
x   <- list(1, b=2)

L  <- list(list(1,2), list(a=1, b=2), list(1, b=2))

x  <- NULL
x  <- ""
x  <- NA

names(list(1,2)) == ""
nms  <- names(list(1,2))
nms
is.na(nms)
nms==""

vapply(L, names, character)
purrr::map_chr(L, names)
nms  <- names(x) 
nms
length(nms)
is.na(nms)
nms == ""


}
```
```{r render, eval=FALSE, include=FALSE 	} 
# TODO:  file is found when knitr runs (see above)

# file must be of form:
# dir/name_of_this_file    where dir is relative to project root

file  <-"rmd/0089_lapply_sapply.Rmd" 

# in general, pdf will look nicer
rmarkdown::render(basename(file),
                  #output_format = "pdf_document",
                  output_format = "html_document",
                  output_file = "~/Downloads/print_and_delete/out")
```
