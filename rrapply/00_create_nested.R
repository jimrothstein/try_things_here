
library(tidyr)
library(purrr)


##  list of 132 elements, each is list of 20 char
l <- replicate(
  132,
  as.list(sample(letters, 20)),
  simplify = FALSE
)
l
str(l, max.level=2, list.len=3)


x1  <- l %>% tibble()
x1
x1 # list of 132, each elemnt is list of 20


purrr::pluck(x1, 1,1)
x1[[c(1,1)]]

str(x1[[c(1,1)]], max.level=2, list.len=3)
x1[[c(1,1)]] %>% unnest_longer(1)



# ------- NO NO !! Change attributes:    tibble becomes data.frame !---------------------------
typeof(x1)          # list
attributes(x1)

y = as.data.frame(x1)
attributes(y)  <- list(class = "data.frame")
head(y)
typeof(y)          # still list
is_tibble(y)       # FALSE
is.data.frame(y)   # TRUE

# --------------------------------------------


# ---------------------  unravel data.frame -----------------------
df = data.frame(a=letters[1:3],
  b=LETTERS[1:3])
df
attributes(df)
class(df)

#  pull named list
  z  <- unclass(df)
  z                 # named list 
  class(z)


# pull out character
  z1  <- unlist(z)    # named character (atomic) 
  z1
  is.atomic(z1)       # TRUE
  class(z1)             # character
  typeof(z1)
# --------------------------------------------
