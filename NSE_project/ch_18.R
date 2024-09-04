# Chapter 18 
library(rlang)
library(lobstr)
------------------------ 18.3.1 
rlang::is_syntactic_literal(1) #T
rlang::is_syntactic_literal(c(1,2)) #F

# self-quote (logical, string (char[1]), number)
identical(expr(TRUE), TRUE)
identical(expr("a"), "a") #  T
identical(expr(1), 1) #  T

# careful....
identical(expr(T), T) #F
identical(expr(T), TRUE) # F



------------------------ 18.3.2
# TWO Ways to create symbol
is.symbol(expr(mtcars)) #T variable to symbol
is.symbol(sym("x")) # T   string to symbol
x=expr(mtcars)   # x is symbol

# TEST is.symbol

# BUT, mtcars itself is list, not a symbol 
is.expression(expr(mtcars))   # F
is.expression(x)   # F,  x is symbol, beter to use hadly

# Hadley is consistent
is_expression(expr(mtcars))   # T
is_expression(x) #T

x = expr(mtcars)
is.symbol(x)    # YES

expr(f(x,"y",1))
ast(f(x,"y",1))
ast(f(mtcars))

# Base::expression
expression(a+b+c)
expression("a" + b +c)
is.expression(expression(1)) #T

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

