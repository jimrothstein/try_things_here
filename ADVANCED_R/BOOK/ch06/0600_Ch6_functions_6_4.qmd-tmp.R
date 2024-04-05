 
 
 
 
knitr::opts_chunk$set(echo = TRUE,  
                      comment="      ##",  
                      error=TRUE, 
                      collapse=TRUE)
library(magrittr)
library(lobstr)
library(jimTools)
``` 

## Chapter 6.2 
```{r 6.2}
f <- function(x) {
	# comment
	x + y
}
body(f)
attr(f, "srcref") # includes comments
ref(f)
obj_size(f)
 
 
 
lapply(mtcars, function(x) length(unique(x)))

# base::Filter( FUN, x) returns whether predicate (logical) or not?
Filter(function(x) !is.numeric(x), mtcars)

# integrate (FUN)
integrate(function(x) sin(x) ^ 2, 0, pi)
 
 
 
 
# functions in lists
funs <- list(
  half = function(x) x / 2,
  double = function(x) x * 2
)

funs$double(10)   # cute!


# TWO ways to call function:
mean(1:10, na.omit=T)

args  <- list(1:10, na.omit=T)
do.call(mean, args) # I LIKE!


# Object can have many references to it
match.fun("mean") # says UseMethod("mean")
UseMethod("mean")  # error

# =================
# function(x) 3()
# (function(x) x)(3)
# =================
#
# b/c inside (), says evaluate and print
# FUN (3), whether or not has a name
(function(x)  x)(3)

# note:  <fn>, no name but exists!
str(function() x)
attr(function() x, "srcref")
ref((function(x)  x))
ref(function(x)  x)
args(function(x) x)

# note: <dbl>
ref((function(x)  x)(3))

(f  <- function(x) x)(3) # not anonymous

f(3)
f
str(f)

# function(x) 3()
# 
function(x) 3()
function(x) 3(4)
# hmmm thinks it is function!
ref(function(x) 3())
attr(function(x) 3(), "srcref")
body(function(x) 3())
formals(function(x) 3())
args(function(x) 3())
 
 
 
  f1 <- function(x) (x - min(x)) / (max(x) - min(x))
  f2 <- f1
  f3 <- f1

	# all the same
	f1
	f2
	f3
 
 
 
 
::: formals, body, environment :::
 
 
 
f02  <- function(x,y) {
	# comment
	x + y
}

# list
formals(f02)

# body (w/o comments)
body(f02)

# created in GlobalEnv
environment(f02)

# attributes
attributes(f02)

# body, includes comments
attr(f02, "srcref") 
# 
 
 
 
 
::: no body, no formals, no evironment :::
 
 
sum
`[`

# environment(sum)  # NULL b/c primitive
# environment(`[`)
environment(f02)

typeof(sum)
typeof(`[`)
# 
 
 
 
 
::: 1st class means can manipulate environment, scope :::
::: Reification  :::
 
 
 
# bind the object to name
f01  <- function(x) sin(1/x)

# functions, BUT without binding to any name 
lapply(mtcars, function(x) length(unique(x)))
Filter(function(x) !is.numeric(x), mtcars)

# this is NEW: list of functions
	funs <- list(
  	half = function(x) x / 2,
  	double = function(x) x * 2
	)
	funs$double(10)

	# How about?
	funs(10)
	rlang::last_error()
#  
 
 
 
 
 
 
 
 
 
# compare Filter to lapply

# 1st unlist
l  <- list(a=c(10,20,30), b=c(TRUE,FALSE), c=c("hello", "bye"))
# return vector, with all the atomic pieces
unlist(l)

# 2nd code:
base::Filter
lapply

# compare: 
f <- is.numeric()

# return list
lapply(l, is.numeric)

# returns vector with all the atomic results
Filter(is.numeric, l)

# to see why, run Filter's code, step-by-step
f  <-  function(x) is.numeric(x)
unlist(lapply(l,f))# atomic, logical, plus names
as.logical(unlist(lapply(l,f))) # atomic, logical vector, no names

ind  <- as.logical(unlist(lapply(l,f))) 
which(ind) # return index which are TRUE
# same as Filter:
l[which(ind)] # subset original list, see all atomic elemtns
# 
 
 
 
 
 
::: two ways :::
 
 
 
# 1 usual way
mean(1:10, na.rm=T)

# 2 do.call: unwrap list ?  
# when args are a LIST, 
args  <- list(1:10, na.rm=TRUE)
do.call(mean, args)

# FAILS 
# mean(args)
# 
 
 
 
 
# 
 
 
 
 
# skip
But NOTE, 3 paragraphs from end:  Hadley  is slighlty inconsistent:
first is f.g and the last two are g.f
Posted to github for advanced-r book,  under 'nit picking'

Example
 
 
f  <- function(x) sin(x)

g  <- function(x) 1/x

# combine: f.g
# quite differnt!
x  <-  pi
h  <- x %>% g() %>% f()
h

# g.f
x  <-  pi
H  <- x %>% f() %>% g()
H
```#  


**Investigate using cat()**
 ```{r r_obseve, include =FALSE, eval = FALSE	}# 
Observe:
In following, x, y are evaluated only when called.  This is clearer by aadding cat(x) ; cat (y) and then REVERSE.
Merely printing a variable forces evalution!
 
 
 
# Question 5, lazy valuation
reprex({
f1 <- function(x = {y <- 1; 2}, y = 0) {
	cat(x)
	cat(y)
  c(x, y)
}

x=NULL
y=NULL
f1() # 2, 1
})
```# 


### 6.4 Lexical Scoping# 
```{r 6.4_text, eval=FALSE	, echo=TRUE}
Purpose: Find the value (or object?) to bind to a name.
Which x?
 
 
x <- 10
g01 <- function() {
  x <- 20
  x
}
g01()
x
 
 
# Result?
g02  <- function(x) {
	#print(pryr::promise_info(x))$eval
	x
}
a  <-3
b  <- 5
x  <- 10
g02(a+b)
# 
#
 
 
 
-	name mask
- fcts are objects 
- separate invoction (no memory)
- WHEN:   Dyanmic 
 
 
 
# MASKING:
# which x,y to use?  
x <- 10
y <- 20
g02 <- function() {
  x <- 1
  y <- 2
  c(x, y)
}
g02()
# 
 
 
 
 
 
 
 
 

# which g07 runs?
g07  <- function(x) x + 1
g08  <- function() {
	g07  <- function(x) x + 100
	g07(10)
}
g08()


# RULE:  When R searches for function g09, non-functions are ignored.
# What prints?
g09  <- function(x) x + 100
g10  <- function() {
	g09  <- 10
	g09(g09)
}
g10()

# 
 
 
 
 
 
 
 
 
# && stops if 1 term is FALSE	
# assume non-vector
x_ok <- function(x) {
  !is.null(x) && length(x) == 1 && x > 0
}

x_ok(NULL)
x_ok(1)
x_ok(1:3)
# 
 
 

x_ok <- function(x) {
  !is.null(x) & length(x) == 1 & x > 0
}
x_ok(NULL)
x_ok(1)
x_ok(1:3)  # vector!
}
 
 
# lazy
f2 <- function(x = z) {
  z <- 100
  x
}
f2()
 
 
 
# print x, forces evaluate x
# see more clearly, put cat(x) or cat (y) 
b  <- current_env()
y <- 10
f1 <- function(x = {y <- 1; 2}, y = 0) {
	a <<- fn_env(f1)
  c(x, y)
}
f1()
y
a
b
 
 
 
 
 
 
 
 
 
 
 
f  <- function() x+1  

# first
x  <- 10
f() #11


# change f env
e  <- env(x=5)
fn_env(f)  <-  e
f() #6


# 3, try another new env
e1  <- env(base_env(), x=3)
fn_env(f)  <- e1
f()  #4

# Finally, right back to `first`, x =
fn_env(f)  <- global_env()
f()   # 11
# 
 
 
 
 
 
 
seq_fn  <- c("sum", "mean", "sd")
data  <- 1:5
sapply(seq_fn, do.call, list(data))
#   sum  mean    sd 
# 15.00  3.00  1.58 

## OR ##

unlist(sapply(seq_fn, base::Map, list(data)))
 
 
 
 
setwd("~/code/book_advanced_R/")
here()
file <- "006_functions.Rmd"
file  <- basename(file)
dir <- "R"

jimTools::ren_pdf(file,dir)
jimTools::ren_github(file, dir)
