#### switch()
###

##  convert yes/no answers to 1,0

start = c("yes", "yes", "no", "")

end = sapply(start, function(e) switch(e,
                                  yes = 1,
                                  no = 0,
                                       "bad data")
             )





EXPR <- "c"
switch(EXPR,
  "a" = "one",
  "b" = "two",
  "c" = "three",
  "d" = 2 + 3,
  stop("not valid choice")
)

styler::style_file("~/code/try_things_here/BASE/300_base_switch.R")
lintr::lint(filename = "~/code/try_things_here/BASE/300_base_switch.R")
