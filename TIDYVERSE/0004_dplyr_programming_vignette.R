# 004_dplyr_programming.R

# see: https://cran.r-project.org/web/packages/dplyr/vignettes/programming.html

# tags:   referential integrity


library("tidyverse")


# ---- dplyr problem ----

# works fine
df <- tibble(x = 1:3, y = 3:1)
filter(df, x == 1)

# but this fails (ie symbolic)
my_var <- x # error
filter(df, my_var == 1) # error

# and  this fails
# TODO (jim)
my_var <- "x = 1"
filter(df, my_var) # error


# ---- introduce .data ------

mutate_y <- function(df) {
  # is "a" column or variable?
  mutate(df, y = a + x)
}

# if a is variable, success
df1 <- tibble(x = 1:3)
a <- 10
mutate_y(df1)

# but  if we meant a is column (and forgot it to include)
df1 <- tibble(x = 1:3)
mutate_y(df1) # throws NO error!, wrong a!

# solution! .data
mutate_y <- function(df) {
  mutate(df, y = .data$a + .data$x)
}
mutate_y(df1) # throws error, unambiguous


df <- tibble(
  g1 = c(1, 1, 2, 2, 2),
  g2 = c(1, 2, 1, 2, 1),
  a = sample(5),
  b = sample(5)
)
df
