### Chapter 6.5

<!-- 6.5 Lazy -->
<!-- promises -->


### 6.5 Lazy Evaluation#  
In R, objects bind to a `symbol`.
Humans like names.   So we assign a name like `f`.

Promises, **are not R code**,  so can not be maniuplated with R code.  
Chapter 20:  convert promises to `quosures` (ie objects)
# 

h01 <- function(x) {
  10
}
h01(stop("This is an error!")) #> [1] 10

# ---------------
## ASIDE:  Lazy
# ---------------
#### Lazy Evaluation:  example
  *  REF: https://rfordatascience.slack.com/archives/C01SHS2Q9HV/p1635341136017800
  *  Ask:  why \code{.} ?
  *  Trigger for evaluation is ?
{

    first  <- function() {
    print("first")
    return()
    }

    second  <- function(.) {
    print("second")
    return(.)
    }


    third  <- function(.) {
    # lazy:  no need to evaluate \code{.} yet
    print("third")
    return(.)
    }
}

# new version of R
    first() |> second() |> third() 

# tidyverse magrittr
    first() %>% second() %>% third() 

# ---------------
#6.5.1 Promises 
    # expression
    # environment
# ---------------
 

3rd criteria for promise is a value that:
is computed, just once, cached, and in its own env.


double  <- function(x) {
	message("Calculating ...")
	x*2
}

h03  <- function(x) {
	c(x,x)                                # only looks up x ONCE 
}
h03(double(20))                        # evaluated before h03 runs 

# --------------
# compare to :
# --------------
h03A  <- function(x) {
	c(abs(double(x)),double(abs(x)))}

# 2 times
h03A(20)

# 3 times
h03A(double(20))

# compare to :
h03B  <- function(x) {
	c(double(x),double(x))
}

# why twice?
h03B(20)

# 


# ----------------------------
#### 6.5.2 Default arguments
# ----------------------------

```{r}
h05  <- function(x=ls()) {
	a=1
	x
	#ls(envir=env_parent())
}

# compare 
h05() # inside function
h05(ls()) # global
h05(ls(envir=env_parent())) # 1 above global!

env_has(current_env(), "h05") #T

```

#### remove - compare NULL, rm(), exists(), missing(
```{r aside}
x  <- NULL
lobstr::ref(x)
exists(x)
missing(x)

rm(x)
lobstr::ref(x)
exists(x)
missing(x)
```

````
#   #### 6.5.3 missing
Who supplied x value?  inside function or outside?
````

```{r 6.5.3_missing }
rm(y) # note:   rm(y) and y  <- NULL not the same

h06 <- function(x = 10) {
  list(missing(x), x)
}

str(h06(y)) # ERROR

str(h06()) # TRUE
str(h06(1)) # FALSE	

y  <- 100
str(h06(y)) # FALSE	 

rm(y)
str(h06(y  <- 3))  #FALSE	


# BUT
args(sample)

`%||%` <- function(lhs, rhs) {
  if (!is.null(lhs)) {
    lhs
  } else {
    rhs
	}
}

5 %||% NULL
NULL %||% 5
#  

```
<!-- BEGIN HERE -->
>
####
Which values will apply to a, b?
Surprise!  In  g, R calcs x lazy... x looks for values in enclosed env(Global)
>

```{r}
f  <- function(x) x
g  <- function(x) {a <- 20; b <- 30; x 
}
a  <- 3
b  <- 5
f(a+b)


```

````

SAME as above, but check env; bind new value for a in env_parent a
changes the `promise`

````

```{r}
g  <- function(x) {
	cat(env_names(current_env()), "\n")
  cat(	env_names(env_parent()), "\n")
	rlang::env_bind(env_parent(), a=200)
	print(pryr::promise_info(x))
	a <- 20; b <- 30; x 
}
a  <- 3
b   <- 5
g(a+b) #205
```
```{r 1002 }
SAME as above, but check env; use <<-  
```
```{r}
g  <- function(x) {
	cat(env_names(current_env()), "\n")
  cat(	env_names(env_parent()), "\n")
	#env_bind(env_parent(), a=200)
	a <<- 200
	a <- 20; b <- 30; x 
}
g(a+b) #205
```
```{r 1003}
SAME as above, but check env; and change env
NOPE
NOPe
```
```{r}
g  <- function(x) {
	cat(env_names(current_env()), "\n")
  cat(	env_names(env_parent()), "\n")
	set_env(current_env())
	cat(env_names(current_env()), "\n")
	a <- 20; b <- 30; x 
}
x  <- NULL
a  <- 3
b  <- 5
g(a+b) #8
```

```{r}

# more promise
f  <- function(x) pryr::promise_info(x)$env
f(2)
x  <- NULL

g  <- function(x) { cat("promise env: ")
			pryr::promise_info(x)
			x
			}
g(x)

h  <- function(x) {
	pryr::promise_info(x)
	x  <- 2
	g(x) }

x  <- 1
h(x)

```

```{r 6.5.4 Problem 3}
# if reverse order of cat(x) and cat(y) result will be x=2 y=0
y  <- 10
f1  <- function(x= {y  <- 1; 2}, y=0) {
	# x is unevaluated; y is set to default 0
	cat(x) # force x evaluation, x=2, and y=1
	cat(y) # y=1
	c(x,y)
}

# no promise here.
f1() # 
y  # 10

# a promise?
x <- 5
f1(x)
f1(x <- 5)
```

# --------
## ASIDE
# --------
h <- function(x) {
	# 	printing ...
	#   cat ... can not handle <env>
	# not done (lengthy output)
  #print(pryr::promise_info(x))

	# skip this;  superceded, but not sure by what
	if (F) {
	library(pryr)
	e  <-  pryr::promise_info(x)
	}

	print(e$code)
	print(e$env)
	print(e$evaled)
}
h(2 + 1)
# 
```
####simplest promise?  
```{r simplest}
y  <- 10
h000  <- function(x){
	y <- 100
	print(rlang::env_get(rlang::current_env(),"y"))
	print(rlang::env_get(rlang::caller_env(),"y"))
}
h000() # note:  `x is <missing>`, user did not provide
```
### order printed 
```{r two} 
# Why does rlang::env_print() appear first?
y <- 10
h02 <- function(x) {
  y <- 100
	print(rlang::current_env())
	print(rlang::caller_env())
	print(rlang::env_get(rlang::current_env(),"x"))  # value of x=10
	x+1
}
h02(y)
h02(y+1)

# 

```

````	
