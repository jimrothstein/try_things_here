
<!-- 6.5 Lazy -->
<!-- promises -->
**To Render**\# {{{

useful rlang functions \# {{{

``` r
e  <- current_env()

# show bindings  SAME ls()
env_names(e)
      ## [1] "e"      "params"
# more details
env_print(e)
      ## <environment: 0x34f73e8>
      ## parent: <environment: global>
      ## bindings:
      ##  * e: <env>
      ##  * params: <list> [L]

# total number of bindings?
env_length(e)
      ## [1] 2

env_inherits(e, env_parent()) # T
      ## [1] TRUE
env_inherits(e, base_env()) # T
      ## [1] TRUE
caller_env()
      ## <environment: 0x5c43e70>
# }}}
```

### 6.5 Lazy Evaluation\# {{{

``` r
In R, objects bind to a `symbol`.
Humans like names.   So we assign a name like `f`.

Promises, **are not R code**,  so can not be maniuplated with R code.  
Chapter 20:  convert promises to `quosures` (ie objects)
# }}}
```

6.5.1 Promises \# {{{

``` r

h <- function(x) {
  print(pryr::promise_info(x))
    x
}
h(2 + 1)
      ## $code
      ## 2 + 1
      ## 
      ## $env
      ## <environment: 0x34f73e8>
      ## 
      ## $evaled
      ## [1] FALSE
      ## 
      ## $value
      ## NULL
      ## [1] 3
```

}}}
===

    simplest promise?

{{{
===

``` r
y  <- 10
h000  <- function(x){
    y <- 100
    list(rlang::env_get(rlang::current_env(),"y"),
             rlang::env_get(rlang::caller_env(),"y")
    )
}

h000() # note:  `x is <missing>`, user did not provide}}}
      ## [[1]]
      ## [1] 100
      ## 
      ## [[2]]
      ## [1] 10
```

<!-- BEGIN -->
``` r
# Why does rlang::env_print() appear first?
# Compare:  h02 and h02A
y <- 10
h02 <- function(x) {
  y <- 100
  list( x + 1, 
             rlang::env_get(rlang::current_env(),"x"),  # value of x=10
             rlang::caller_env(), rlang::current_env(),
             rlang::env_print()
    )
}
h02(y)
      ## <environment: 0x50efd78>
      ## parent: <environment: 0x34f73e8>
      ## bindings:
      ##  * y: <dbl>
      ##  * x: <dbl>
      ## [[1]]
      ## [1] 11
      ## 
      ## [[2]]
      ## [1] 10
      ## 
      ## [[3]]
      ## <environment: 0x34f73e8>
      ## 
      ## [[4]]
      ## <environment: 0x50efd78>
      ## 
      ## [[5]]
      ## <environment: 0x50efd78>

y <- 10
h02A <- function(x) {
  y <- 100
  list( x + 1, 
             rlang::env_get(rlang::current_env(),"x"),  # value of x=10
             rlang::caller_env(), rlang::current_env()
    )
}
h02A(y)
      ## [[1]]
      ## [1] 11
      ## 
      ## [[2]]
      ## [1] 10
      ## 
      ## [[3]]
      ## <environment: 0x34f73e8>
      ## 
      ## [[4]]
      ## <environment: 0x4eaa4d0>
# }}}
```

Of the 3 criteria for promise, the 2nd is env for the calc. What will print? {{{

``` r
y  <- 10
h02  <- function(x) {
    y  <- 100
    x + 1 # x draws from .Globalenv
}

h02(y)
      ## [1] 11
h02(y+1) # when y+1 evaluated?  in  what env? 
      ## [1] 12
```

    3rd criteria for promise is a value that:
    is computed, just once, cached, and in its own env.

``` r

double  <- function(x) {
    message("Calculating ...")
    x*2
}

h03  <- function(x) {
    c(x,x)
}

h03(double(20))
      ## Calculating ...
      ## [1] 40 40

# compare to :
h03A  <- function(x) {
    c(abs(double(x)),double(abs(x)))}

h03(as.double(20))
      ## [1] 20 20
h03(20/2)
      ## [1] 10 10

# 2 times
h03A(20)
      ## Calculating ...
      ## Calculating ...
      ## [1] 40 40

# 3 times
h03A(double(20))
      ## Calculating ...
      ## Calculating ...
      ## Calculating ...
      ## [1] 80 80

# compare to :
h03B  <- function(x) {
    c(double(x),double(x))
}

# why twice?
h03B(20)
      ## Calculating ...
      ## Calculating ...
      ## [1] 40 40

# }}}
```

#### 6.5.2 Default arguments

``` r
library(rlang)
h05  <- function(x=ls()) {
    a=1
    x
    #ls(envir=env_parent())
}

# compare 
h05() # inside function
      ## [1] "a" "x"
h05(ls()) # global
      ##  [1] "double" "e"      "h"      "h000"  
      ##  [5] "h02"    "h02A"   "h03"    "h03A"  
      ##  [9] "h03B"   "h05"    "params" "y"
h05(ls(envir=env_parent())) # 1 above global!
      ##  [1] "counter_one" "e"           "f"          
      ##  [4] "h"           "h000"        "new_counter"
      ##  [7] "out"         "power1"      "power2"     
      ## [10] "ren"         "ren2"        "square"     
      ## [13] "x"           "y"

env_has(current_env(), "h05") #T
      ##  h05 
      ## TRUE
```

#### 6.5.3 missing

``` r
args(sample)
      ## function (x, size, replace = FALSE, prob = NULL) 
      ## NULL

`%||%` <- function(lhs, rhs) {
  if (!is.null(lhs)) {
    lhs
  } else {
    rhs
    }
}

5 %||% NULL
      ## [1] 5
NULL %||% 5
      ## [1] 5
```

> Which values will apply to a, b? Surprise! In g, R calcs x lazy... at that time a,b are in g env.

``` r
f  <- function(x) x
g  <- function(x) {a <- 20; b <- 30; x 
}
a  <- 3
b  <- 5
f(a+b)
      ## [1] 8
```


    SAME as above, but check env; bind new value for a in env_parent a
    changes the `promise`

``` r
g  <- function(x) {
    cat(env_names(current_env()), "\n")
  cat(  env_names(env_parent()), "\n")
    rlang::env_bind(env_parent(), a=200)
    print(pryr::promise_info(x))
    a <- 20; b <- 30; x 
}
a  <- 3
b   <- 5
g(a+b) #205
      ## x 
      ## b a g f %||% h05 h03B h03A h03 double h02A h02 h000 y h e params 
      ## $code
      ## a + b
      ## 
      ## $env
      ## <environment: 0x34f73e8>
      ## 
      ## $evaled
      ## [1] FALSE
      ## 
      ## $value
      ## NULL
      ## [1] 205
```

``` r
SAME as above, but check env; use <<-  
      ## Error: <text>:1:6: unexpected symbol
      ## 1: SAME as
      ##          ^
```

``` r
g  <- function(x) {
    cat(env_names(current_env()), "\n")
  cat(  env_names(env_parent()), "\n")
    #env_bind(env_parent(), a=200)
    a <<- 200
    a <- 20; b <- 30; x 
}
g(a+b) #205
      ## x 
      ## b a g f %||% h05 h03B h03A h03 double h02A h02 h000 y h e params
      ## [1] 205
```

``` r
SAME as above, but check env; and change env
NOPE
NOPe
      ## Error: <text>:1:6: unexpected symbol
      ## 1: SAME as
      ##          ^
```

``` r
g  <- function(x) {
    cat(env_names(current_env()), "\n")
  cat(  env_names(env_parent()), "\n")
    set_env(current_env())
    cat(env_names(current_env()), "\n")
    a <- 20; b <- 30; x 
}
x  <- NULL
a  <- 3
b  <- 5
g(a+b) #8
      ## x 
      ## x b a g f %||% h05 h03B h03A h03 double h02A h02 h000 y h e params 
      ## x
      ## [1] 8
```

``` r

# more promise
f  <- function(x) pryr::promise_info(x)$env
f(2)
      ## <environment: 0x34f73e8>
x  <- NULL

g  <- function(x) { cat("promise env: ")
            pryr::promise_info(x)
            x
            }
g(x)
      ## promise env:
      ## NULL

h  <- function(x) {
    pryr::promise_info(x)
    x  <- 2
    g(x) }

x  <- 1
h(x)
      ## promise env:
      ## [1] 2
```

``` r
h06  <- function(x=10)
    list(missing(x),x)
}
# missing true if user doesn't provide arg
str(h06()) # TRUE
str(h06(2)) # FALSE
str(h06(y<-3)) # FALSE  hah (promise)

      ## Error: <text>:3:1: unexpected '}'
      ## 2:         list(missing(x),x)
      ## 3: }
      ##    ^
```

``` r
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
      ## 21
      ## [1] 2 1
y  # 10
      ## [1] 10

# a promise?
x <- 5
f1(x)
      ## 50
      ## [1] 5 0
f1(x <- 5)
      ## 50
      ## [1] 5 0
```
