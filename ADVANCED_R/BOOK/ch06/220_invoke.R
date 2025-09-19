f 0600_Ch6_functions_6_4.R

## Chapter 6 - 6.4.5  FUNCTIONS
# TODO
# - match.fun still a little hazy

library(lobstr)

# ------------------------------------
## Chapter 6.2 
##  formals, body, scref of function
# ------------------------------------
f <- function(x) {
	# comment
	x + y
}
  formals(f) # $x  plus initial value, if any.
# 
  body(f)	    # source, but excludes non-code 
# {
#     x + y
# }

  attr(f, "srcref") # source, includes comments
# function(x) {
# # comment
# x + y
# }
  attributes(f)
  lobstr::ref(f) # [1:0x565226943738] <fn> 
  lobstr::obj_size(f) # 3.38 kB

# ---------------------------------------------
# Difference between args(f)  and formals(f)?
  # args(f) for interactive
  # formals(f) for coding (longer, list-like)
# NOTE: args(f) is for INTERACTIVE use, use `formals` in CODING.
# ---------------------------------------------
  args(f)                              # for interactive, use formals in coding. 
# function (x) 
# NULL


args(lm)
# function (formula, data, subset, weights, na.action, method = "qr", 
#     model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
#     contrasts = NULL, offset, ...) 
# NULL
if (F) formals(lm)                     # lengthy list 

# each column
lapply(mtcars, function(x) length(unique(x)))

# base::Filter( FUN, x), each element returns whether predicate (logical) is true
Filter(function(x) !is.numeric(x), mtcars)  # no columns
Filter(function(x) is.numeric(x), mtcars)   # all columns

?Filter


# integrate (FUN)
integrate(function(x) sin(x) ^ 2, 0, pi)


# --------------------
# functions in lists
# --------------------
funs <- list(
  half = function(x) x / 2,
  double = function(x) x * 2
)

funs$double(10)   # cute!


# ----------------------------
# TWO ways to call function: f() and do.call(f, list)
# ----------------------------
mean(1:10, na.omit=T)


# but if args is mixed list, problem
args  <- list(1:10, na.omit=T)
mean(args)   # NA and warnings

# use this
do.call(mean, args) # I LIKE!


# ---------------------------------------
# Object can have many references to it
# USE CASE  match.fun()
# Given quoted function name, R can not always tell true function
# ---------------------------------------
# USE CASE:

# Works
fun  <- list(`*`, `sin`)
fun[[1]](2,3)

# Fails (b/c char)
fun2  <- list("*", "sin")
fun2[[1]](2,3)

# Fix ... given name of func (as char), return true functino
match.fun(fun2[[1]])(2,3) # [1] 6

match.fun("mean") # says UseMethod("mean")

# but
x=mean
match.fun(x)
match.fun("mean")
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

### 6.2.1 Function components
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

### 6.2.2 Primitives, sum#  
::: no body, no formals, no evironment :::
sum
`[`

# environment(sum)  # NULL b/c primitive
# environment(`[`)
environment(f02)

typeof(sum)
typeof(`[`)
# 

### 6.2.3 Functions are objects ("First Class functions")# 
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


Aside  base::Filter(), breakdown:#	


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


### 6.2.4 Invoking Fuction# 
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

### 6.2.5 EXERCISES# 
# 

### 6.3 function composition# 
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


**Investigate using cat()**
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


