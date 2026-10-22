---
TAGS:  data.table, tutorial, joins
---
library(jimTools)
library(magrittr)
library(data.table)


### REF:  franknarf1.github.io/r-tutorial/_book/tables.html

{  ## magrittr example

### be sure to understand


f = . %>% paste("ya!") %T>% print %>% toupper
f("hi")
# [1] "hi ya!"
# [1] "HI YA!"
}

{ ## example data

DT = data.table(
  x = letters[c(1, 2, 3, 4, 5)], 
  y = c(1, 2, 3, 4, 5), 
  z = c(1, 2, 3, 4, 5) > 3
)

#  note .. to subset columns
keep_cols  <- c("y", "z")
DT[, keep_cols]
DT[, ..keep_cols]   


DT[, z]

# note: 
DT[,  .(y,z)]

}

{ ## 3.2.4.3 `Subset using i; Group using by; Do j`

  # The third major difference is the extension of the DT[...] syntax to support more than simple slices (like DF[i,j], where i and j as indices, covered in 3.2.2). It offers SQL-style syntax that is cleaner, particularly for by-group operations:
  # 
  #(pseudocode)
  # DT[where, select|update|do, by] # SQL verbs
  # DT[i, j, by]                    # R function arguments
  # 
  # This should be read as a command to take a sequence of steps:
  # 
  #     Subset using i
  #     Group using by
  #     Do j
  # 
  # We can use column names as `barewords`, and even form expressions in terms of columns:

DT[x > "b", sum(y), by=z]
}

{  ## JOINS 3.5
a = data.table(id = c(1L, 1L, 2L, 3L, NA_integer_), t = c(1L, 2L, 1L, 2L, NA_integer_), x = 11:15)
a
#    id  t  x
# 1:  1  1 11
# 2:  1  2 12
# 3:  2  1 13
# 4:  3  2 14
# 5: NA NA 15


b = data.table(id = 1:2, y = c(11L, 15L))
b
#    id  y
# 1:  1 11
# 2:  2 15

# equi-join (equality)
# The idiom for a simple equi join is x[i, on=.(...)] or x[i] for short:

#  NOTE
# for every i in b, include match in a  (like using a as a lookup table)
a[b, on=.(id)]
#    id t  x  y
# 1:  1 1 11 11
# 2:  1 2 12 11
# 3:  2 1 13 15
#

# watch the criteria!
a[b, on=.(x = y)]
#    id  t  x i.id
# 1:  1  1 11    1
# 2: NA NA 15    2
#
# see results for every row of i (rows of b), even those that are unmatched.
# LOST! equality??
a[b, on=.(id, x = y)]
#    id  t  x
# 1:  1  1 11
# 2:  2 NA 15
# }
#
#
{  ## aggregate
  # use b to find rows in a, then sum a$x , grouping on each id 
  #
  a[b, on=.(id), sum(x), by=.EACHI]
