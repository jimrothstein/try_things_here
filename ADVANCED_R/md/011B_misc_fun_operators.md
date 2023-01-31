011B\_misc\_fun\_operators.Rmd
================

Chapter 11 - MISC - Function Operators
--------------------------------------

Take 1 (or more) FUN, return single, modified FUN

``` r

# USAGE:  catn(counter, str1, str2, ... strn)
catn  <- function(counter=0, ...) {
                env_poke(caller_env(), "counter", counter +1)
            cat(counter, ..., "\n" )
}

# a BUGS !
counter  <- 0
catn(counter,"hel","lo")
      ## 0 hel lo
catn(counter, "hel",3,"lo")
      ## 1 hel 3 lo
```

``` r
# ============================================ 
## From Companion Chapter 10 10.1, w/o force # 
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
      ## 0 outer:current_env:  <environment: 0x6178b00> 
      ## 1 outer:env_parent:  <environment: 0x39b6dc0> 
      ## 2 outer:fn_env:  <environment: 0x39b6dc0> 
      ## 3 outer:enclosure:  <environment: 0x39b6dc0> 
      ## 4 outer:promise$code x 
      ## 5 outer:promise$env <environment: 0x39b6dc0> 
      ## 6 outer:promise$evaled FALSE 
      ## 7 outer:promise$value
exp  <- 2
x  <- 4
square(x)
      ## 8 inner:execution environment:  <environment: 0x63451a0> 
      ## 9 inner:enclosure:out:   <environment: 0x6178b00> 
      ## 10 inner:promise$code x 
      ## 11 inner:promise$env <environment: 0x39b6dc0> 
      ## 12 inner:promise$evaled FALSE 
      ## 13 inner:promise$value
      ## [1] 256

#square
knitr::knit_exit()
# ======
x  <- 2
square(3)
      ## 8 inner:execution environment:  <environment: 0x64e9dc8> 
      ## 9 inner:enclosure:out:   <environment: 0x6178b00> 
      ## 10 inner:promise$code x 
      ## 11 inner:promise$env NULL 
      ## 12 inner:promise$evaled TRUE 
      ## 13 inner:promise$value 4
      ## [1] 81

```
