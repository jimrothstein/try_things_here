
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

#  6.4.2 Lexical also applies to functions

# which g07 runs?
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
# ---------------------------------------------------------------------




#### 6.4.5 Exercises# 

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
***
#### 6.4.4 DYNAMIC - change env of f# 

More with Ch 6.4.4# 
Tinker with env, before running f()
CHANGE env, then run FUN

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



####    do.call(f, list of args), apply data to list of functions
seq_fn  <- c("sum", "mean", "sd")
data  <- 1:5
sapply(seq_fn, do.call, list(data))
#   sum  mean    sd 
# 15.00  3.00  1.58 

## OR ##

unlist(sapply(seq_fn, base::Map, list(data)))


