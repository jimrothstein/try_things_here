011B\_misc\_fun\_operators.Rmd
================

Chapter 11 - MISC - Function Operators
--------------------------------------

Take 1 (or more) FUN, return single, modified FUN

``` r
TEST, this is markdown, not rmarkdown?
x <-2
**bold**
```

    To Render# {{{  

``` r
# {{{

# USAGE:  catn(counter, str1, str2, ... strn)
catn  <- function(counter=0, ...) {
                env_poke(caller_env(), "counter", counter +1)
            cat(counter, ..., "\n" )
}

# a BUGS !
catn("hel","lo")
      ## Error in counter + 1: non-numeric argument to binary operator
catn("hel",3,"lo")
      ## Error in counter + 1: non-numeric argument to binary operator
# }}}
```

``` r
# ============================================ 
## From Companion Chapter 10 10.1, w/o force # {{{
# ============================================
```

``` r

suppressMessages(requireNamespace("pryr"))

# make sure this isn't already defined
rm(x)
      ## Warning in rm(x): object 'x' not found
power2 <- function(exp) {
    counter  <- 0
    e  <- current_env() 
    catn(counter,  "outer:current_env: ",capture.output(e) )
    catn(counter, "outer:env_parent: ", capture.output(env_parent(e)))      
    catn(counter, "outer:fn_env: ", capture.output(rlang::fn_env(power2)      ))

    catn(counter, "outer:enclosure: ", capture.output(env_parent(environment())))

    catn(counter, "outer:promise$code", pryr::promise_info(exp)$code)
    catn(counter, "outer:promise$env", capture.output(pryr::promise_info(exp)$env))
    catn(counter, "outer:promise$evaled", pryr::promise_info(exp)$evaled)
    catn(counter, "outer:promise$value", pryr::promise_info(exp)$value)

  out <- function(x_) {
        e  <- current_env()
    catn(counter, "inner:execution environment: ", capture.output(e))
    catn(counter, "inner:enclosure:out:  ", capture.output(fn_env(out)))

    catn(counter, "inner:promise$code", pryr::promise_info(exp)$code)
    catn(counter, "inner:promise$env", capture.output(pryr::promise_info(exp)$env))
    catn(counter, "inner:promise$evaled", pryr::promise_info(exp)$evaled)
    catn(counter, "inner:promise$value", pryr::promise_info(exp)$value)

    x_ ^ exp
  }
}
rm(x)
      ## Warning in rm(x): object 'x' not found
square <- power2(x)
      ## 0 outer:current_env:  <environment: 0x5a01be0> 
      ## 1 outer:env_parent:  <environment: 0x3ea8a28> 
      ## 2 outer:fn_env:  <environment: 0x3ea8a28> 
      ## 3 outer:enclosure:  <environment: 0x3ea8a28> 
      ## 4 outer:promise$code x 
      ## 5 outer:promise$env <environment: 0x3ea8a28> 
      ## 6 outer:promise$evaled FALSE 
      ## 7 outer:promise$value
exp  <- 2
x  <- 4
square(x)
      ## 8 inner:execution environment:  <environment: 0x5c5a970> 
      ## 9 inner:enclosure:out:   <environment: 0x5a01be0> 
      ## 10 inner:promise$code x 
      ## 11 inner:promise$env <environment: 0x3ea8a28> 
      ## 12 inner:promise$evaled FALSE 
      ## 13 inner:promise$value
      ## [1] 256

#square
knitr:exit()
      ## Error in eval(expr, envir, enclos): object 'knitr' not found
# ======
x  <- 2
square(3)
      ## 8 inner:execution environment:  <environment: 0x5e3bc48> 
      ## 9 inner:enclosure:out:   <environment: 0x5a01be0> 
      ## 10 inner:promise$code x 
      ## 11 inner:promise$env NULL 
      ## 12 inner:promise$evaled TRUE 
      ## 13 inner:promise$value 4
      ## [1] 81

# }}}
```

EXAMPLE: chatty()

\`\`\`r

{{{
===

probe internals of functonal, like purrr::map\_int()
====================================================

Given FUN f, chatty modifies behavior:
--------------------------------------

chatty &lt;- function(f) { \# not run print(pryr::promise\_info(f))

    #force(f) not necessary?
    #cat(x) error, no x (at this point)

    function(x, ...) {
        r  <- f(x, ...)
        cat("Processing ", x, "\n", sep="")
        r
    }

}

f &lt;- function(x) x^2 s &lt;- c(3,2,1) purrr::map\_dbl(s, chatty(f)) \`\`\`\# }}}

      ## Error: attempt to use zero-length variable name

\`\`\`

``` r
purrr::safely
      ## function (.f, otherwise = NULL, quiet = TRUE) 
      ## {
      ##     .f <- as_mapper(.f)
      ##     function(...) capture_error(.f(...), otherwise, quiet)
      ## }
      ## <bytecode: 0x3b5f868>
      ## <environment: namespace:purrr>
sin_safe  <- purrr::safely(sin(0),1)
sin_safe()
      ## $result
      ## [1] 1
      ## 
      ## $error
      ## <simpleError in pluck(x, 0, .default = NULL): argument "x" is missing, with no default>
# }}}
```

``` r

# =================
# purrr::as_mapper()# {{{
# =================
```

``` r
# REF: https://jennybc.github.io/purrr-tutorial/ls01_map-name-position-shortcuts.html

# see how this works
map_dbl(mtcars, ~ length(unique(.x)))
      ##  mpg  cyl disp   hp drat   wt qsec   vs   am 
      ##   25    3   27   22   22   29   30    2    2 
      ## gear carb 
      ##    3    6

# 1, take formula, return function (g)
g  <- as_mapper( ~ length(unique(.x)))
g
      ## <lambda>
      ## function (..., .x = ..1, .y = ..2, . = ..1) 
      ## length(unique(.x))
      ## <environment: 0x3ea8a28>
      ## attr(,"class")
      ## [1] "rlang_lambda_function"
      ## [2] "function"

# 2
map_dbl(mtcars, g)
      ##  mpg  cyl disp   hp drat   wt qsec   vs   am 
      ##   25    3   27   22   22   29   30    2    2 
      ## gear carb 
      ##    3    6

## NeXT
l  <- list(a="one", b="two", c="three")
pluck(l, "a")
      ## [1] "one"

getter  <- function(x, letter) x[[letter]]
getter(l,"a")
      ## [1] "one"

# list of lists
l1  <- list(a="a", b="b", c="c")
l2  <- list(a=1, b=2, c=3)
l3  <- list(a="joe", b="john", c="moe")
l  <- list(l1=l1, l2=l2, l3=l3)


# extract "c"
g  <- as_mapper("c", .default=NULL)
map(l, g)
      ## $l1
      ## [1] "c"
      ## 
      ## $l2
      ## [1] 3
      ## 
      ## $l3
      ## [1] "moe"

map(l, `[`, c("a","c"))
      ## $l1
      ## $l1$a
      ## [1] "a"
      ## 
      ## $l1$c
      ## [1] "c"
      ## 
      ## 
      ## $l2
      ## $l2$a
      ## [1] 1
      ## 
      ## $l2$c
      ## [1] 3
      ## 
      ## 
      ## $l3
      ## $l3$a
      ## [1] "joe"
      ## 
      ## $l3$c
      ## [1] "moe"
map(l, h, c("a","c"))
      ## Error in as_mapper(.f, ...): object 'h' not found

# extract "a" and "c"
h  <- as_mapper(`[`, .default=NULL)
map(l, h, c("a","c"))
      ## $l1
      ## $l1$a
      ## [1] "a"
      ## 
      ## $l1$c
      ## [1] "c"
      ## 
      ## 
      ## $l2
      ## $l2$a
      ## [1] 1
      ## 
      ## $l2$c
      ## [1] 3
      ## 
      ## 
      ## $l3
      ## $l3$a
      ## [1] "joe"
      ## 
      ## $l3$c
      ## [1] "moe"

    ###
f  <- purrr::as_mapper(~ .x + 1)
f(2)
      ## [1] 3

f  <- purrr::as_mapper(sin)
f(0)
      ## [1] 0
f(3.14/2)
      ## [1] 1
# }}}
```

``` r
# KEEP
# When  knitr, global_env is not be listed as such.
# knitr's global... so expect unusual output.
# BUT,  knitr env still show hierarachy.

y  <- 1
current_env()
      ## <environment: 0x3ea8a28>
f  <- function() {
    info()
}



info  <- function() list(current = current_env(), caller = caller_env(),
    caller_parent = caller_env(n=2))

info()
      ## $current
      ## <environment: 0x5627398>
      ## 
      ## $caller
      ## <environment: 0x3ea8a28>
      ## 
      ## $caller_parent
      ## <environment: 0x56274b0>

f()
      ## $current
      ## <environment: 0x56a9328>
      ## 
      ## $caller
      ## <environment: 0x56a9398>
      ## 
      ## $caller_parent
      ## <environment: 0x3ea8a28>
```
