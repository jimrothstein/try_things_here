# 003_purrr_attributes.R

# This code plays with attr, attributes of vectors
# See: http://adv-r.had.co.nz/Data-structures.html#vectors
# See: http://adv-r.had.co.nz/Subsetting.html#subsetting-operators

##  June 2019  -version 2
##  See: https://adv-r.hadley.nz/vectors-chap.html

# TODO(jim)

library(tidyverse)

# ----- prelim -----
x <- 1:3
is_vector(x) # T
is_atomic(x) # T
is_list(x) # F

# -- since x  vector, ask --
typeof(x) # integer
length(x) # 3

# ---- GW Section 20.4.5 (subset) ----
#  filter() works for tibble, what do we do?

x <- c("one", "two", "three", "four", "five")
is_vector(x)
is_atomic(x)
is_list(x)
is_numeric(x) # F
is_character(x) # T
typeof(x)

# get subset of x
# 1.   use numeric vector of integers to subset
x[c(3, 2, 5)]

# create new vector as long as you like, by repeating
x[c(1, 1, 5, 5, 5, 2)]

# negative, omit
x[c(-1, -3, -5)] # "two" "four"

# but can not mix
x[c(-1, -3, -5, 2)] # Error

# zero?   character(0)
x[c(0)]
x[0]

# ---- subset with logical ----

x <- c(10, 3, NA, 5, 8, 1, NA)
typeof(x) # double
length(x) # 7
x[!is.na(x)] # 10,3,5,8,1
x[x %% 2 == 0] # 10,NA,8,NA  (NA strange)




##      ATTRIBUTES
##  Think of as key=value metadata, attached to vectors
##

x <- NULL
# to get attributes
attributes(x) # NULL

x <- c("one", "two", "three", "four", "five")

# ----- Set attributes: myName, age -----
attr(x, "myName") <- "I am x"

attr(x, "myName") # displays only value
attributes(x) # displays attributes and value

# set age
attr(x, "age") <- 3
attributes(x)
attr(x, "age")

str(attributes(x))

##  Alternative way to create vector with attributes
y <- structure(
  c("one", "two", "three", "four", "five"),
  age = 3,
  myName = "I am x"
)
str(attributes(y))

## ATTRIBUTES tend not to last
attributes(length(x)) # NULL
attributes(x[2]) # NULL

##  TWO attributes that linger:   dim, names


# ----- set element names -----

x <- set_names(1:3, c("first", "second", "third")) # must create new vector, x
names(x)
str(x)
attributes(x)
str(attributes(x))

## 2nd way to set names
y <- 1:3
names(y) <- c("first", "second", "third")

##
x["third"]
x

# ----- preserve -----
y <- x[3]
names(y) # "third"
is_vector(y) # T
is_atomic(y) # T
is_list(y) # F
attributes(y) # lost those attr for x as a whole
str(y)
typeof(y)
y

# ---- simplify ----
y <- NULL
y <- x[[3]]
names(y) # NULL !
is_vector(y) # T
is_atomic(y) # T
is_list(y) # F
attributes(y) # NULL
str(y) # nothing?
typeof(y)
is_vector(y) # T
is_atomic(y) # T
is_list(y) # F
attributes(y) # lost those attr for x as a whole
str(y)
y # print name and value

# ---- unname ----
unname(y)
y # NOT print name

str(x)
names(x)
str(x)
attributes(x)
x["third"]
x
print(x)
