#   GOAL:   tibble a nested lists, as return from api
#   SEE:    https://stackoverflow.com/questions/4227223/convert-a-list-to-a-data-frame
#
#   rbind vs. do.call(rbind,...)   see /home/jim/code/try_things_here/BASE/108_matrix_do_call_rbind.qmd
#
#   GOAL:   Make Tibble
#   FIRST, understand rbind better
library(tibble)
library(purrr)

# a list containing 132 lists, each length 20
L <- replicate(
  132,
  as.list(sample(letters, 20)),
  simplify = FALSE
)
if (F) {
  length(L)
  lengths(L)
}

##  Many methods, base, tidyverse, clever use  of apply functions, data.table
try( as_tibble(L)


## BEGIN here
# -------------
z = sapply(L,c)   # simplify
dim(z)
# [1]  20 132
t(z) |> head(1)

z = as.data.frame(t(sapply(L,c)))
dim(z)
# [1] 132  20

# -------------
# lapply is not so good
z = lapply(L, c)
length(z)
## use function c(), now list of 132 lists, now each element holds just 1 item, list of 20 characters

# 1 big row, 132 elements, each element is list of 20
z = rbind(L)
z |> head(1)
is.data.frame(z)
length(z)
# [1] 132
z = base::Reduce(rbind, L)
z = base::Reduce(rbind.data.frame, L)
length(z) 
df  <-  data.frame(z)

## From Reddit, more ideas
## https://bityl.co/O3yr
## https://www.reddit.com/r/rstats/comments/rtcgql/q_an_efficient_way_to_convert_lists_nested_within/?share_id=z0tWA14jqhfPEp19jQBne&utm_content=2&utm_medium=ios_app&utm_name=iossmf&utm_source=share&utm_term=22
