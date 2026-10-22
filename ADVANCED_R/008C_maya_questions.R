#### Maya
withCallingHandlers(
  message = function(cnd) cat("Caught a message!\n"),
  {
    message("Someone there?")
    message("Why, yes!")
  }
)

tryCatch(
  message = function(cnd) cat("Caught a message!\n"),
  {
    message("Someone there?")
    message("Why, yes!")
  }
)

error_handler <- function(cnd) {
  message("inside error_handler()")
  cnd_muffle(cnd)
}
warning_handler <- function(cnd) {
  message("inside warning_handler()")
  cnd_muffle(cnd)
}

# Question 7
ignore_log_levels <- function(expr, levels) {
  withCallingHandlers(
    log = function(cnd) {
      if (cnd$level %in% levels) {
        cnd_muffle(cnd)
      }
    }, # end log

    withCallingHandlers(
      warning = warning_handler(cnd),
      expr
    )
  )
} # endfunction
record_log(ignore_log_levels(log("Hello"), "info"))

ignore_log_levels(log("Hello"), "info")

log("Hello") # error
