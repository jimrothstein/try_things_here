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

## PURPOSE:   Examples of lapply, sapply, vapply,mapply
- Must understand lists vs atomic, named
-	examples of lapply
-	canonical form of `lapply`


```{r setup, include=FALSE		}
knitr::opts_chunk$set(echo = TRUE,
                      comment = "      ##",
                      error = TRUE,
                      collapse = T   ) # easier to read
```

### Subset, Extract
  *  [, [[, $

```{r subset}
a  <- c(1,2,3)
a[2]
a[a>2]
a[a%%2 == 0]

f  <- function(x) x ==1
a[f(a)]


# list
lapply (a, f)
lapply (a, `[`)


tryCatch({ 
         lapply(a, `[[` )},
          error = function(e) {"No good - error" }
)
```


###	canonical form,  ie a function applied to (list, f)
```{r canonical}
`lapply` (a, f)
```


#### list, can subset, append, walk  ... this is hard one.
```{r list}
l.1 <- list(letters, zz=4)
length(l.1)

l[length(l)]
l[1:3]


l.2  <- append(l.1, letters)
length(l.2)


l.2[2]
l.2[2:5]

# my favorite!
l.2[c(2,3,10, 26)]

l.2$zz
names(l.2)
```
#### lapply: function works on list, returns a list.
```{r simple_list}

# named list
l  <- list(a = rnorm(5), b = rnorm(5))
l

# named list  
ans  <- lapply(l, mean)
is.list(ans)
ans


args(lapply)
```

```{r simple_extract}
l  <- list(a = c("A", "B"),
           b = c("C", "D"))
names(l)
l[1]
l[[1]]

dt  <- data.table(a=l[1], b=l[2])
dt

    dt  <- data.table(l)
    dt
    #      l
    # 1: A,B
    # 2: C,D

    # wrong
    lapply(l, function(e) e)
    lapply(l, function(e) e[1])
    lapply(l, function(e) e[[1]])

    vapply(l, function(e) e, FUN)

    # wrong
    purrr::map_chr(l, function(e) e)
    purrr::map_chr(l, function(e) e[1])
    purrr::map_chr(l, function(e) e[[1]])



```


### simplification
  *  several functions try to simplify structure
  * c()
  * unlist()

```{r simplify}

# named
x  <- c(a="ONE", b="TWO")
x

# c() returns simplified
x  <- c(1,2, c(3,4))
x

# c() simplies tries to keep names
x  <- c(1, 2, d = c(3,4))
x

x  <- c(1, 2, c(3,4))
is.list(x)   # F
is.integer(x) # F
is.double(x)   # TRUE
```
#### lapply on named char[]:  preserves names!
```{r named_char}
x  <- c(a="ONE", b="TWO")
names(x)

y  <- lapply(x, function(x) x)
names(y)

identical(names(x),names(y))
# [1] TRUE
```
#### lapply - tricky
```{r challenge}
## unnamed chr[]
  x  <- c("ONE", "TWO")

## returns named list 
  f  <- function(x) {list(my_name = x)}
  f(x)

## Is y named or unnamed?
  y  <- lapply(x, f)

## BE SURE to UNDERSTAND
## ans:  unnamed !
  names(y)  
  str(y)  # list of 2 elements, each holds named char[1]
```



### unlist as simplifier
```{r unlist}

# unlist() is another simplifier , here returns atomic vector rather than list
l  <- list(a=c(1,2), b=c(3,4))
l

# pattern ?!
ans  <- unlist(l)
ans

is.double(ans)  # T
names(ans)
length(ans)  # 4
```


### sapply:  
  *  Rather than list, try to return vector, matrix, or array (if simplify=TRUE)
```{r sapply}
args(sapply)

# sapply is 'smarter', if see scalers and returns vector[] instead.
sapply(v, mean) # return vector!

# named list 
l <- list(a=1:5, b=6:10)

sapply(l, mean) # named atomic


# first, do not simplify
ans  <- sapply(l, `[`, simplify=F)
class(ans)
attributes(ans)
ans


# second, do simplify (default) Surprise !
ans  <- sapply(l, `[`)
class(ans)
attributes(ans)
ans
```

#### lists: more subset
```{r study}

# STUDY
# for each element of list, return contents first element
value  <- function(e) e[[1]] 
lapply(l, value)

lapply(l, typeof)

# (default) returns names, char[]
v  <- vapply(l, typeof, FUN.VALUE=character(1))
```

```{r not_sure}

lapply(C.1, function(y) y)

# comes back named! Look at code for sapply
sapply(C.1, function(y) y)
names(sapply(C.1, function(y) y))

vapply(C.1, function(y) y, character(1))
names(vapply(C.1, function(y) y,  character(1)))

```

```{r runif}


#-----------------
# runif | runif(n) returns double[] n values from uniform distr
# ---------

# to check
args(runif)

runif(3)

lapply(1:4,runif) # treats 1:4 as list, retuns list
```

Replicate():
  *  replicate is version of sapply
  *  simply=FALSE ; returns list of vectors
  *  DEFAULT: would return array or matrix

```{r }
n  <- 3

# returns matrix
l  <- replicate(3, rnorm(5))
is.matrix(l)

# returns list
l  <- replicate(3, rnorm(5), simplify = FALSE )
is.list(l)
l

lapply(l, mean)
```


### vapply(x, fun(x), typeof(x))
```{r vapply}

#  integer(1) creates 0
#  integer(2)         0 0
#
n  <- 10^3

# create int[] of length n, filled with 1:n
if (FALSE )
  seq_len(n)

# fills x 1:n
x  <- vapply(seq_len(n), function(i) {i}, integer(1))
head(x)
x  <- NULL
```
### vapply examples
```{r vapply_examples}
n  <- 10^3
# creates all zeroes
x  <- vapply(seq_len(n), function(i) {integer(1)}, integer(1))
head(x)


# remove entries 
v  <- double()
v  <- c(1,2,3, 2019, 2020, 2021, 2022)
typeof(v)

vapply(v, function(x) {if (x > 2020) x  <- NA; x}, double(1))

```

### Misc related code (TODO)
```{r misc_code}

# =======================================
#  MISC CODE with vapply, lists, char, NULL, NA
## TO DO 
l  <- list(a="jim", b="joe", c="cindi")
# =======================================

names  <- names(l)
names

tags  <- vapply(l, `[`, character(1), USE.NAMES=FALSE)
tags
##   change NULL to NA:
##   NULL is dropped
x  <- c(NULL, 3, "a")
x
##   but NA is OK
z   <- c(NA, 3, "a")
z


y  <- NULL
is.null(y)

if (is.null(y)) y  <- NA
is.null(y)

## as.character()  strips names!
##
x  <- list(a= "ONE", b="TWO")
x
is.character(x)


y  <- as.character(x)
y
names(y)



x

y  <- sapply(x, `[` )  # keeps names
y
names(y)
is.character(y)
length(y)
y[1]

```

sapply - rules (SEE: https://stackoverflow.com/questions/12339650/why-is-vapply-safer-than-sapply/12340888#12340888)
sapply - given length 0 input, almost always returns empty list
```{r}
##  identity returns its argument
  sapply(1:5, identity)
  ## [1] 1 2 3 4 5

##  zero length:  sapply returns list
  sapply(integer(), identity)
# list()
  sapply(list(), identity)
# list()
  sapply(c(), identity)
# list()

# list()
  length(array())  # 1
  sapply(array(), identity)
# [1] NA
  sapply(date(), identity)

  # empty function is actually length=1
  z = sapply(function() {}, identity)
  length(function(){}) #1
  length(z) #1
# [[1]]
# {
# }
# 
length("")   # length = 1 !
length(character(0))   # length = 0 !
length(character(1))   # length = 1 !


##  same, vapply - always 

  vapply(1:5, identity, integer(1))
# [1] 1 2 3 4 5
  if(F) vapply(1:5, identity, "")   # "" denotes character(1) which fails

  vapply(integer(), identity, integer(1))
# integer(0)
  vapply(list(), identity, integer(1))
# integer(0)
  vapply(c(), identity, integer(1))
# integer(0)

  vapply(character(), identity, character(0))
# <0 x 0 matrix>
  vapply(character(), identity, character(1))
# named character(0)
  vapply(character(), identity, character(2))
#     
# [1,]
# [2,]
  vapply(character(), identity, character(3))
#     
# [1,]
# [2,]
# [3,]


##

## list()    
vapply(1:5, identity, integer(1))
## [1] 1 2 3 4 5
vapply(integer(), identity, integer(1))
## integer(0)
```

#### Nested lists

```
  *  Nested Lists.  Flatten only lists that are below level 1. Or `bubble`
     ‘vapply’ returns a vector or array of
     type matching the ‘FUN.VALUE’.  If
     ‘length(FUN.VALUE) == 1’ a vector of
     the same length as ‘X’ is returned,
     otherwise an array.  If ‘FUN.VALUE’
     is not an ‘array’, the result is a
     matrix with ‘length(FUN.VALUE)’ rows
     and ‘length(X)’ columns, otherwise an
     array ‘a’ with ‘dim(a) ==
     c(dim(FUN.VALUE), length(X))’.

     The (Dim)names of the array value are
     taken from the ‘FUN.VALUE’ if it is
     named, otherwise from the result of
     the first function call.  Column
     names of the matrix or more generally
     the names of the last dimension of
     the array value or names of the
     vector value are set from ‘X’ as in
     ‘sapply’.
```{r vapply_intro}
args(vapply)
# function (X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE) 


x  <- c(1.1, 2.2, 3.3)
vapply(x, function(x) x*2, double())
vapply(x, function(x) x*2, double(1))


## array: 2 x length(x)
vapply(x, function(x) c(x, x-1), double(2))
vapply(x, function(x) c(x, x-1), c(1,2))
```

```{r vapply}
x  <- list(NULL, "", NA, list())
vapply(x, length, logical(c(0,1)))
vapply(x, f, logical(1))
```

#### more lapply ??
```{r lapply   }


f.1  <- function(x) {
  lapply(x, function(y) y)
}

# no suprises
f.1(L.1)
f.1(L.2)

lapply(L.1, function(y) y)
lapply(L.2, function(y) y)

sapply(L.1, function(y) y)
sapply(L.1, function(y) y, USE.NAMES = T)
vapply(L.1, function(y) y, character(2))

```

#### Does lapply drop attributes?
```{r attributes}
##  simple list
    l  <- list(1,2,3)
    attributes(l)

##  add attribute
    l2  <- l
    attributes(l2)  <- list(name = "jim")
    attributes(l2)

##  lose attribute!
    f  <- function(e) e*3

    lapply(l, f)
    (l2  <- lapply(l2, f))
    attributes(l2)


## To maintain attributes, use l2[]
    l2[] = lapply(l2, f)
    attributes(l2)
    

```


#### lapply and returning functions, with promise
```{r lapply_returns_functions}

prepend_text = function(text) {
  function(x) {
    paste(text, x)
  }
}
x  <- c("one", "two", "three")


f  <- prepend_text("hello")
f(x)

### list of functions
lapply(x, prepend_text)


### BUT ...  this is CUTE!
### lapply preserves names
names(x)  <- x
x
l  <- lapply(x, prepend_text)
l  <- lapply(x, prepend_text("hello"))
l
# $one
# [1] "hello one"
# 
# $two
# [1] "hello two"
# 
# $three
# [1] "hello three"
# 

#### Mixing vapply, map and purrr?

Use improved has_name()
* test collection with vapply
* purrr
```{r improved}

has_name(NULL)
has_name("")
has_name()
has_name(list())
has_name(list(a=1, b=2))
has_name(list(a=1, 2))
has_name(list(1, 2))



vapply(L1, has_name, logical(1))
vapply(list(1,2), has_name, logical(1))

```

### Filter:  LEGACY, from advancedR  006_functions.R
```{r legacy}
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
```

#### Analyze lappy?   Chatty(f) yields info.   
  *  chatty is a function that returns a new function, `function operator`
  *  See Adv-R, Chapter 11
```{r chatty}

## original function:
  f  <- function(e) e
  v  <- 3:1

  ## no suprise, returns list
  lapply(v, f)


## chatty takes f, adds functionality and returns new function 
  chatty  <- function(f) {
    force(f)

  function(x) {
    res  <- f(x)
    cat("Processing ", x, "\n", sep="")
    res 
  }
}

## create new verson of f
    g  <- chatty(f)


## apply it
lapply(v, g)

## better?
sapply(v, g)
# Processing 3
# Processing 2
# Processing 1
# [1] 3 2 1
```


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
#### dt, mapply takes 2 columns and produces 3rd
```{r mapply_dt}
library(data.table)

dt  <- data.table(x=letters[1:5], y=letters[1:5])

f  <- function(x, y) {
    paste0(x, "-", y)
}

dt[, .(new = mapply(f, x,y))]


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
