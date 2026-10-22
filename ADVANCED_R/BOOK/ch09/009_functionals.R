# Chapter 9 - Functionals

#


# Examples - same -
map_dbl(mtcars, function(x) length(unique(x)))
map_dbl(mtcars, \(x) length(unique(x)))

map_dbl(mtcars, ~length(unique(.x)))   # use .x
map_dbl(mtcars, ~length(unique(..1)))   # use  ..1

library(purrr)

# ======================
## 9.1
# ======================
## f: vector -> scalar
randomise  <- function(f) f(runif(1e3))

randomise(mean)
randomise(median)

# ========================================
#### 9.2 purrr:::map() <list>  -> <list>
# ========================================

triple  <- function(x) x*3
map(1:5, triple)

# simpler version of map
simple_map <- function(x, f, ...) {
  out <- vector("list", length(x))
  for (i in seq_along(x)) {
    out[[i]] <- f(x[[i]], ...)
  }
  out
}

# FAILS, map_dbl:  <list>  -> double[]
# specifically,   x is scalar, f(x) must also be scalar
# but this is not double
pair <- function(x) c(x, x)
map_dbl(1:2, pair)
####

l  <- list(c(1,1), c(2,2))
typeof(l)
is.atomic(l) # FALSE


#### 9.2.2 

# purrr::as_mapper() translates FORMULAS into functions
## SO?
as_mapper(~ length(unique(.x)))

# STEP1 each element of 1:3 return 2 numbers
x <- map(1:3, ~ runif(2))
str(x)

## STEP2, create function to do this 
g  <- as_mapper( ~ runif(2))
g(1:3)

## If LIST
## SHORTCUTS, to extract from list;
# map_dbl(<list>, "x") # extract named elment x

##### review purrr::pluck ####
# from help:

     obj1 <- list("a", list(1, elt = "foo"))
     obj2 <- list("b", list(2, elt = "bar"))
     x <- list(obj1, obj2)


pluck(x,1)
pluck(x,1,2)

pluck(x,1,2,"elt")
pluck(x,1,2,2) # SAME


##### purrr::as_mapper()
```{r as_mapper}
# REF: https://jennybc.github.io/purrr-tutorial/ls01_map-name-position-shortcuts.html

# 
map_dbl(mtcars, ~ length(unique(.x)))

# STEP 1, take formula, return function (g)
g  <- as_mapper( ~ length(unique(.x)))
g

# STEP 2
map_dbl(mtcars, g)
# but this differs
g(mtcars)

## NeXT, LISTS with as_mapper()

# one way
l  <- list(a="one", b="two", c="three")
pluck(l, "a")

# another
getter  <- function(x, letter) x[[letter]]
getter(l,"a")


# review:   purrr::pluck()
# as_mapper is great for list of lists
l1  <- list(a="a", b="b", c="c")
l2  <- list(a=1, b=2, c=3)
l3  <- list(a="joe", b="john", c="moe")
l  <- list(l1=l1, l2=l2, l3=l3)

# walks ....
pluck(l, 1)
pluck(l, 2 )
pluck(l, 1, 2)
pluck(l, 3, "c")
# pluck(l,c(1,2,3), "c")


# create function to extract "c"
# study
as_mapper("c", .default=NULL)

g  <- as_mapper("c", .default=NULL)
l
map(l, g) # as list
map_chr(l, g) #as chr[]


# example, extract a & c:  one way:
map(l, `[`, c("a","c"))

# with as_mapper,  extract elements named "a" and "c"
# NOTE:  in this form, values to be extracted are arbitrary!
h  <- as_mapper(`[`, .default=NULL)
map(l, h, c("a","c"))
map(l, h, c("b"))


# same l (list of lists)
l[[2]][["b"]]

as_mapper(list(2,"b"))  # x[[2]][["b"]]


g  <-  as_mapper(list(2,"b"))
g(l)

# =====
# more FORMULA to function, with as_mapper

f  <- purrr::as_mapper(~ .x + 1)
f(2)

f  <- purrr::as_mapper(sin)
f(0)
f(3.14/2)


# 2 or more arguements?
x  <- 0:3
y   <- 10:13
z   <- 20:23

f  <- as_mapper(~ ..1 + ..2 + ..3)
f(x,y,z)

```
#### Section 9.2.3
# ==================

x  <-list(1:5, c(1:10, NA))
map_dbl(x, ~ mean(.x, na.rm = TRUE))

# shortcut
map_dbl(x, mean, na.rm =TRUE)


## COMPARE TO:
# CLEARER: 
plus <- function(x, y) x + y
x <- c(0, 0, 0, 0)
map_dbl(x, ~ plus(.x, runif(1))) # nonsense if runif(2)

# shorcut can confuse
map_dbl(x, plus, runif(1))  # plus has no .... in args.

# ========================
#### Section 9.2.4 Names
# ========================



# ========================
#### Section 9.2.6 EXERCISES
# ========================

# 1.
map_lgl

# 2.
map
map(1:3, ~ runif(2))

map(1:3, runif(2)) # here, map thinks it is runif(2) is extra arugment.

# 3
str(mtcars)

hello
h lk


# ======================
# chapter 9.4.3 (walk)
# ======================

# problem, cat has a return value: NULL
# is this returned 'invisible' ?

x  <- "john"
y  <- cat("Welcome ", x, "!\n", sep="")
y  # NULL

# HOWEVER,  map returns  list; sent to console.
names  <- c("Hadley", "Jenny")
map(names, ~ cat("Welcome ", .x, "!\n", sep=""))

# How to fix? walk() sideeffects:   because it returns .invisible
walk(names, ~ cat("Welcome ", .x, "!\n", sep=""))






#
# ========================
#### PLAY:  Take 2 vectors, create 1 list 
# ========================

# ===========================
# RULE1:  structure --> new structure
# ====================================

# MAP one structure (parallel vectors) to one NEW structure (1 vector)
R2  <- function(v1,v2, f) {
	if (length(v1) != length(!v2) ) abort("length must be same")
  #new  <- map2(v1,v2,~ c(..1,..2)	)
	new  <- map2(v1,v2, f)
}

# ===========================
# RULE2:   node --> new node
# ===========================

# each NODE, R  --> R^2
combine  <- function(x,y) c(x,y)


v1  <- runif(10)
v2  <- runif(10)
z  <- R2(v1,v1,combine) 
z

# =========================
## 9.5.1  REDUCE - basics
# =========================

# what does this do?
l  <- map(1:4, ~sample(1:10,15, TRUE))


# reduce works through a list recursively?  takes 2 vectors, returns 1
# f(f(1,2),3)..   reduce(1:3, f)

purrr::reduce(l, intersect)

purrr::reduce(l, union)

# EXAMPLE with .x, .y,   reduce (.x, .f)  where f takes 2 args.
# something like f(1,2, rest)  becomes f(3,4, rest)
reduce(1:100, ~ .x+ .y)
reduce(1:100, ~ ..1 + ..2)



# ===================
## 9.5.2 ACCUMULATE
# ===================
# like reduce, but shows each iteration


# BUG?   if length = 0 or 1, reduce my stumble
#
reduce("a", `+`) # returns arg, without checking (b/c lenght(x) =1 s/d this)
reduce("a", `+`, .init =0 # forces add identity force it to check inputs
reduce("a", `*`) # returns arg	
reduce("a", `*`, .init=1) # shows error (which want)

# =====================
9.5.4 MULTIPLE INPUTS
# =====================


## NOTE:  functor laws, map id to id; and preserve composition

# https://en.wikipedia.org/wiki/Functor_(functional_programming)
## modify(.x, .f, ...) vs map:   return object of same type as input
?purrr::modify


# split (by grouping)
split(mtcars, mtcars$cyl)
