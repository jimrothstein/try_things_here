library(TidyDensity)
x <- mtcars$mpg # 32 values

z <- tidy_bootstrap(x)

# examine first set
is_double(unlist(z[1, 2])) # named double, 25 values
first <- unlist(z[1, 2])
first

names(first)
unname(first)
