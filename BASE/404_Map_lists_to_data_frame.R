## 0404_Map_lists_to_data_frame.R
## 	REF:   Reddit
## https://bityl.co/O6Q9

## 	TAGS:  Map, mapply, rbind, list

## PURPOSE:		Given a not-to-complicated nested list, transform to data.frame
## USE				Use BASE tools. Map

## 	Of course, tidyverse has wonderful tools
## 	But base tools work and can be simpler, less to remember.

## Given

my_list <- list(
  AA001 = list(x = 1:5, y = 1:5),
  BB001 = list(x = -1:-5, y = -1:-5),
  CC001 = list(x = rep(99, 5), y = rep(0, 5))
)


## WANT   df:   id*, x, y

names(my_list)
# [1] "AA001" "BB001" "CC001"

## 	Map over each name, one at a time to build 3 data.frame
##  Map sees 3 names, so knows to extract 3 lists from my_list
Map(\(i, j) data.frame(i, j), names(my_list), my_list)


## 	mapply NOT what I expect
if (F) {
  mapply(\(i, j) data.frame(i, j), names(my_list), my_list)
}


## 	rbind accepts vectors, matrix, data.frame
## rbind to form one big data.frame from 3 smaller data.frame
df <- do.call(rbind, Map(\(i, j) data.frame(i, j), names(my_list), my_list))
df



f <- function(i, j) list("title" = i, "d" = j)
f <- function(i) list("title" = i$title, "d" = i$d)

L <- list(
  list(title = "a", d = "b"),
  list(title = "xyz", d = "abc")
)
dput(L)

do.call(rbind, Map(f, L))

######    replace map with Map
library(purrr)

test <- function(x) {
  list(a = mtcars[1:2, 1:2], b = iris[1:2, 1:2])
}

out <- map(1:2, test) |>
  transpose() |>
  map(list_rbind)


map(1:2, test) |>
  transpose() |>
  dput()
str(out, max.level = 1)
