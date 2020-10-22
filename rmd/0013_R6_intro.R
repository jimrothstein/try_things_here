# 013_R6_intro.R


# Tags:   R6, new()
library(R6)

Person <- R6Class("Person",
                  public = list(
                          name = NULL,
                          hair = NULL,
                          initialize = function(name = NA, hair = NA) {
                                  self$name <- name
                                  self$hair <- hair
                                  self$greet()
                          },
                          set_hair = function(val) {
                                  self$hair <- val
                          },
                          greet = function() {
                                  cat(paste0("Hello, my name is ", self$name, ".\n"))
                          }
                  )
)
ann <- Person$new("ann","brown")
ann$hair
ann$name
ann$greet()
ann$initialize()  # reset to defaul!
ann$set_hair("blonde")
ann$hair
