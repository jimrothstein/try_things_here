# 056_R_functional.R
###
# 	source: Text: Mailund Functional R
###

rescale <- function(x, ...) {
  m <- mean(x, ...)
  s <- sd(x, ...)
  (x - m) / s
}
x <- c(1:4)
rescale(x)

# fails
y <- c(NA, 1:3)
rescale(y)

# with ..., can pass ANY named value
rescale(y, na.rm = TRUE)

# NOTE:  foo isn't defined in rescale() [actually sd does not allow ...,
# 	mean does allow for ...;   sd throws errror!]
rescale(y, na.rm = TRUE, foo = 5)

####
# 	...
###

g <- function(x, ...) x
g(1:4)
g(1:4, foo = 4) # takes it!

f <- function(...) list(...)
g <- function(x, y, ...) f(...)
g(x = 1, y = 2, z = 3, w = 4) # z,w passed to f; works!

###
# 	list, alist
###
list(x = 1, y = 2, 3) # works!
alist(x = 1, y = 2, 3) # works!
list(x = 1, y = 2, 3, x) # x not found
alist(x = 1, y = 2, 3, x) # works! lists x for [[4]]


# Display parameters passed ...:
parameters <- function(...) eval(substitute(alist(...)))
parameters(a = 4, b = a**2) # a=4, b=a^2
# repeat with list (vs alist): error 'a' not defined

# Note, examine intermediate steps:
parameters <- function(...) alist(...)
parameters(a = 4, b = a**2) # displays '...'

parameters <- function(...) substitute(alist(...))
parameters(a = 4, b = a**2) # displays 'alist(a=4, b=a^2)

#####
# Functions have no names, assigning a variable to it is for OUR conveniene
(function(x) x^2)(2) # 4

####
# 	LAZY EVALUATION (aka 'by promise')
# 	(expressions evaluate only when needed)
####
evaluate_expression_when_needed <- function(a, b) a

evaluate_expression_when_needed(2, stop("error if evaluated"))
## [1] 2
evaluate_expression_when_needed(stop("error if evaluated"), 2)
# 'error if evaluated'

####
# 	SCOPE? Global vs local, function parameters?
####
# compare:
f <- function(a, b = a) a + b
f(a = 2) # 4
f(2) # 4
f(2, b) # 'object b not found'
f(a = 2, b = a) # 'object a not found'

g <- function(a, b) a
g(a = 2)
g(2)
g(2, b) # 2, works
g(a = 2, b = a) # 2, works
