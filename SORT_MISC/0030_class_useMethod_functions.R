# 030_class_useMethod_functions.R
# Alt - z
# <-

# learn about a function
seq # calls UseMethod()
UseMethod # function

class(seq) # it is  function, object
class(5) # numeric
class("jim") # character
class(mean) # function

View(seq) # appears in new TAB

seq
# R code!
seq.Date
seq.default


# [generic].[class]
class(seq.Date) # function
class(seq.default) # function
class(seq.int) # function
class(seq.POSIXt) # function

# EXAMPLE
# base::UseMethod is figures out class of x
f <- function(x) {
  UseMethod("f")
}

f.default <- function(x) print("f:  default")
f.numeric <- function(x) print("f:  numeric")
f.character <- function(x) print("f: character")
f.list <- function(x) print("f:  list")
f.function <- function(x) print("f:  function")


f(3)
f("a")
f(x) # Error
f(list("a", 2))
f(TRUE)
f(sin)

# S3, s3_dispatch, methods
methods(f)
library(tibble)
methods(class = "tibble")
methods(class = "ts")
methods(class = "factor")
methods(class = "quosure")
methods(class = "language")
methods(class = "data.frame")
