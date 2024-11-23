library(rlang)

# TODO:
# g_  use stand eval
# g   use NSE

#  quote()
quote(x) |> class()            # name
quote(mean(1:10)) |> class()    # call


#  expr()

# NOTES:  class = high level object type
# typeof = low-level object type
# do not use base::expression (confusing)
a = 10
b = 20

quote1 = expr(a+b)    # a + b
quote1 |> class()     # call
is.call(quote1)       # T



eval(quote1)  #  30

# surprise
bquote(.(a) + b)   # list(10) + b

expr(!!a + b)  # 10 + b
expr(!!a + !!b)   # 10 + 20  no eval

eval(expr(a+b))  # 30
eval(expr(!!a+b))  # 30


# deparse, return unevalu string
quote(x + y) |> class()   # class
deparse(quote(x+y)) # "x + y"    # string

deparse(expr(x))  # "x"
deparse(expr(1+2)) # "1 + 2"



# if arg is name, print name and its value
# if arg is call, print call and its evaluation
f  <- function(arg){
  paste0("value of ", deparse(arg), "is ", eval(arg))
 } 

x = 3
f(expr(x))  # value of x is 3
f(expr(sin(pi)))   # value of sin(pi) is  0 (almost)


#  pass a quote to a function, without eval
g = function(q) {q}
g(quote(x))   # x
g(quote(2+3)) # 2 + 3
g(quote(sin(pi + pi))) # sin(pi+pi)


# Do the same WITHOUT quote ?

h = function(q) {substitute(q)}
h(x)   # x
h(2+3) # 2 + 3

# OR use rlang::enexpr

# PROBLEM:  inside a function, expr
# returns x, regardless of what user sent
f <- function(x) {
  expr(x)
}

f(3) # returns x


# another fix without quote(), use enexpr
g_ <- function(x) {
  enexpr(x)
}

g_(3) # returns 3
g_(a + b) # a+b, even though not defined.
a <- 4
g_(a + b)
g_(!!a + b)
