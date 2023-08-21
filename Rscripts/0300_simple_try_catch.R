#!/usr/bin/env Rscript
#  0300_simple_try_catch.R  -- simple try_catch
#
#
# chmod 744 should suffice
#
library(rlang)

# terminates
# if (F) (
# tryCatch ({
#   log("a") })
# )

tryCatch(stop("fred"),  error = function(e) e, finally = print("Hello1"))
tryCatch(abort("fred"),  error = function(e) e, finally = print("Hello2"))
tryCatch(abort("fred", class="xyz"),  
         error.xyz =  function(e) {cat("xyz"); e},
         error = function(e) e, 
         finally = print("Hello2")
)
quit()

tryCatch (
  { rlang::abort("throw an error", class="xyz_error") },
  xyz_error  <- function(e) {
     warn(conditionMessage(e))
     NA
  },

  finally  <- function() print("did we handle the error?")
)


