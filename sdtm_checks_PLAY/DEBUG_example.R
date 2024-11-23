
test <- function(x){
  ##:ess-bp-start::browser@nil:##
browser(expr=is.null(.ESSBP.[["@2@"]]));##:ess-bp-end:##
    mean(x)
}


run  C-c
go to error  C-x ` or M-g n
fix, check in console
set breakpoint  C-c C-t b



test <- function(x){
  ##:ess-bp-start::conditional@!is.numeric(x):##
browser(expr={!is.numeric(x)})##:ess-bp-end:##
x <- x + 1
  y <- mean(x)
  x <- ifelse(x > 5, x, x - 100)
  ##:ess-bp-start::browser@nil:##
browser(expr=is.null(.ESSBP.[["@4@"]]));##:ess-bp-end:##
list(x, y)
}


test(1:5)

test("a")
