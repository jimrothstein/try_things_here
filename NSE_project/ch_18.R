# Chapter 18 
library(rlang)
library(lobstr)
------------------------ 18.3.1 
rlang::is_syntactic_literal(1) #T
rlang::is_syntactic_literal(c(1,2)) #F

identical(expr(T), T) #T
identical(expr(T), TRUE) # F

identical(expr(a), a) # error a not found
a=2
identical(expr(a), a) #  F  (var a is not-self quote)

identical(expr("a"), "a") #  T

------------------------ 18.3.2
# mtcars is  a ??
is.symbol(mtcars)  # F
ast(mtcars)

x = expr(mtcars)
is.symbol(x)    # YES

expr(f(x,"y",1))
ast(f(x,"y",1))
ast(f(mtcars))

------------------------ 18.3.3 call objects
ast(f(mtcars, "a"))

x = expr(f(mtcars,"a"))

is.call(x) #T

# BUT, beware inconsistency, it is a call object
typeof(x)  # language
str(x)     # reports language

------------------------ treat as lists
x[[1]]
x[[2]]
is.symbol(x[[2]]) # T

------------------------ standardized is depricated

# Given an expr and the fn,  call_match returns full fn ? 
z=expr(mean(rnorm(5)))

call_match(z, mean)  # x is call object, mean is fn
#   mean(x = rnorm(5))

