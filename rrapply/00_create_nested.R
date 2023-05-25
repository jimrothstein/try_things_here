library(tidyr)
library(purrr)
#  2023-05-24

##  PURPOSE:   create df with 1 column, each cell is list[20]
##
##  create list of 132 elements, each is list of 20 char
l <- replicate(
    132,
    as.list(sample(letters, 20)),
    simplify = FALSE
)
str(l, max.level = 2, list.len = 3)


##  tidy, as tibble, one column
x1 <- l %>% tibble()
# # A tibble: 132 × 1
#    .
#    <list>
#  1 <list [20]>
#  2 <list [20]>
#  3 <list [20]>
#  4 <list [20]>
#  5 <list [20]>
#  6 <list [20]>
#  7 <list [20]>
#  8 <list [20]>
#  9 <list [20]>
# 10 <list [20]>
# # ℹ 122 more rows

## first column, first row, first letter
purrr::pluck(x1, 1, 1, 1) # [1] "q"

##  first row, first col  is list of 20
x1[1, 1]

x1[1, 1] %>%
    unnest_longer(1) |>
    head(5)
# # A tibble: 5 × 1
#   .
#   <chr>
# 1 q
# 2 e
# 3 s
# 4 l
# 5 o





# ---------------------  unravel data.frame -----------------------
df <- data.frame(
    a = letters[1:3],
    b = LETTERS[1:3]
)
#   a b
# 1 a A
# 2 b B
# 3 c C
#
unlist(df)
#  a1  a2  a3  b1  b2  b3
# "a" "b" "c" "A" "B" "C"
