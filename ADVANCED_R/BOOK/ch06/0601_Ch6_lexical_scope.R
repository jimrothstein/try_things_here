
# ------------ Section 6.4 Lexical Scoping---------------------------------------------------------

-   WHERE (env):  a function looks for variables,  using its env and its rules.
-   WHEN (dynamic):  function needs the variable, using the WHERE rules.  
-   Note:   nothing prevents the variable from being changed over time.


Purpose: Find the value (or object?) to bind to a name.
Which x?

x <- 10
g01 <- function() {
  x <- 20
  x
}
g01()
x

g01_variant <- function(x) {
  x <- 20
  x
}
g01_variant(x)
x


# Result?
g02  <- function(x) {
	#print(pryr::promise_info(x))$eval
	x
}
a  <-3
b  <- 5
x  <- 10
g02(a+b) # [1] 8


#### Features of Lexical Scoping
-	name mask
- functions are objects 
- separate invocation (no memory)
- WHEN:   Dynamic 

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

x <- 1
y  <- 100
g04 <- function() {
  y <- 2
  i <- function() {
    z <- 3
    c(x, y, z)
  }
  i()
}
g04() # [1] 1 2 3

# ------------------------------------------
#  6.4.2 Lexical also applies to functions
# ------------------------------------------

# which g07 runs? (masking)
g07  <- function(x) x + 1
g08  <- function() {
	g07  <- function(x) x + 100
	g07(10)
}
g08()



# RULE:  When R searches for function g09, non-functions are ignored.
# What prints?  [not a good habit]
g09  <- function(x) x + 100
g10  <- function() {
	g09  <- 10
	g09(g09)
}
g10()

# -----------------------------------------
##  An aside, some properties of function
# -----------------------------------------
# given function name, return value (function itself)
match.fun(g09) # function(x) x + 100
class(g09) # [1] "function"
typeof(g09) # [1] "closure"

# - No memory, unless a put into global env---------------
rm(a)
g11 <- function() {
  if (!exists("a")) {
    a <- 1
  } else {
    a <- a + 1
  }
  a
}

g11()
g11()

# ----------------------
#### 6.4.5 Exercises# 
# ----------------------

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
# --------------------------------------
#### 6.4.4 DYNAMIC - change env of f# 
# --------------------------------------

# WHERE:   global env
# WHEN:	   only when must (lazy)
g12 <- function() x + 1
x <- 15
g12() #> [1] 16

x <- 20
g12() #> [1] 21

# ------------------------------
##  ASIDE:  unbound variables?
# ------------------------------
## unbound symbols
codetools::findGlobals(g12) # [1] "+" "x"
codetools::findGlobals(ast)
lobstr::ast(g12()) # █─g12 
lobstr::ast(function() x + 1)
# █─`function` 
# ├─NULL 
# ├─█─`+` 
# │ ├─x 
# │ └─1 
# └─NULL 


# ----------------------------------
# To change WHERE functions looks:
# tinker with function's environemnt
# ----------------------------------
emptyenv() # <environment: R_EmptyEnv>
environment(g12)  <- emptyenv()
environment(g12)
g12()                                  #error:  now can not find `+`   


q

####    do.call(f, list of args), apply data to list of functions
seq_fn  <- c("sum", "mean", "sd")
data  <- 1:5
sapply(seq_fn, do.call, list(data))
#   sum  mean    sd 
# 15.00  3.00  1.58 

## OR ##

unlist(sapply(seq_fn, base::Map, list(data)))


