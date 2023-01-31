------------------------------------------------------------------------

QUESTION

``` r
I was toying with function `sleepy` from `Companion:  Chapter 11.1`
URL:https://r4ds.github.io/bookclub-Advanced_R/QandA/book/function-operators.html

I created two versions of sleepy, one for fixed delay of 1.5 sec and one for variable
delay of n secs.

My original goal was introduce a `bug` into sleepy_print_fixed, along the lines
of Chapter 10.... (and not use tools like fn_env()$n to make a change in
enclosing env)

HOWEVER, __this question is about promises_.   Please examine the results of the
two functions (below). NOTE the TRUE/FALSE.  TRUE means a promise exits and it
has NOT been evaluated.  FALSE means it has evaluated.

I am interested in how promise for `n` propogates to the
anoymous function or not.  Where - exactly - is n evaluated and promise ends?

BONUS:  can you come up a little `bug` either in the functions or Global that
tricks sleepy_print_fixed into lazy evaluation? (no rlang::)
```

``` r
        if(pryr::is_promise(n)) cat("in sleepy1: ",pryr::promise_info(n)$evaled, '\n')

  function(...){
        # cat(
        #     glue::glue('Sleeping for {n} second{ifelse(n != 1, "s", "")}.'), 
        #     sep = '\n'
        # )
        if(pryr::is_promise(n)) cat("in anonymous: ",pryr::promise_info(n)$evaled, '\n')
    Sys.sleep(n + 0)
        #cat(pryr::promise_info(n)$evaled, '\n')
    f(...)
  }

}

# create 2 qunctions
sleepy_print_fixed  <- sleepy1(print, 1.5)
      ## in sleepy1:  FALSE (so exists an unevaluted promise)

sleepy_print_variable  <- sleepy1(print,n)
      ## in sleepy1:  FALSE


n <- 5   # what effect?

sleepy_print_fixed('hello world')
      ## in anonymous:  TRUE  (WHEN was it evaluated?)
      ## [1] "hello world"

sleepy_print_variable('hello world')
      ## in anonymous:  FALSE
      ## Warning in Sys.sleep(n +
      ## 0): restarting interrupted
      ## promise evaluation
      ## [1] "hello world"
```
