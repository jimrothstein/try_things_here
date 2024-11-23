10 / 17 / 20210 / 17 / 20222 ##  Adv_R Functions ##

#
y <- 1
f <- function(y) sin(1) # base class
#
f()
f
body(f) # sin(1)
formals(f) # $y
environment(f) # <environment: R_GobalEnv>
attributes(f) # $srcref
f$srcref
print(f)
class(f) # "function"
class(sin) # function
class(y) # numeric

### sin Primitive?
.Primitive(name = "f") # error, not primitive
.Primitive(name = "sin") # function(x)  .Primitive("sin")    :w
is.primitive(sin)
typeof(sin) # buildin

### check several functions
y <- list(sin, "sin", c, switch, typeof, sqrt, `if`, `+`)

sapply(y, typeof)
sapply(y, is.primitive)
sapply(y, is.function)

library(data.table)
dt <- data.table(
  fun = unlist(y),
  typeof = sapply(y, typeof)
)
dt
unlist(y)


##  EXERCises

objs <- mget(ls("package:base"), inherits = TRUE) # 0,1,n objects
funs <- Filter(is.function, objs)
class(funs) # list
length(funs) # 1207


####
# 	LEXICAL SCOPE
####
f <- function() {
  x <- 1
  y <- 2
  c(x, y)
}
f() # 1 2
rm(f)

x <- 2
g <- function() {
  y <- 1
  c(x, y)
}
g()
rm(g)
rm(x)
rm(x, g)

####
x <- 1
h <- function() {
  y <- 2
  print(environment())
  i <- function() {
    z <- 3
    c(x, y, z)
    print(environment())
  }
  i()
}
h()
search()
i() # error, can't find
rm(x, h)
#####
j <- function(x) {
  y <- 2
  function() {
    c(x, y)
  }
}
k <- j(1) # k is function!
class(k)
k()

rm(j, k)
#####
#####
n <- function(x) x / 2
o <- function() {
  n <- 10
  n(n) # wow, function n using variable n
}
o() # 5
o
n
n() # error, wants an x
####
# 	Fresh Start
####
j <- function() {
  if (!exists("a")) {
    a <- 1
  } else {
    a <- a + 1
  }
  a
}
j()
a # error, no object a
j() # 1, again!   each  call creates new (execution) environment
rm(j)

####
# 	Dynamic
####
f <- function() x + 1
codetools::findGlobals(f)


####
# 	Exercise #2
####
# 1.
c <- 10
c(c = c)
# 3.
f <- function(x) {
  f <- function(x) {
    f <- function(x) {
      x^2
    }
    f(x) + 1
  }
  f(x) * 2
}
f(10) # 202
