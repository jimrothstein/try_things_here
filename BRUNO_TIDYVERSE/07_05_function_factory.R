07_05_function_factory.R

## TAGS: function factory, ..., dots, 

##  PURPOSE:    Given a function f, return both time to run and the result.
##              Function factory (returns functions)
time_f <- function(.f, ...){

  function(...){

    tic <- Sys.time()
    result <- .f(...)
    toc <- Sys.time()

    running_time <- toc - tic

    list("result" = result,
         "running_time" = running_time)

  }
}


g  <- time_f(sum, 1:10^6)
is.function(g)
g()
g()$running_time

