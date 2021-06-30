library("jimPackage")
library(tidyverse)
# ---- x4, NEXT time			----
#
x4 <- list(a=c(100,101), 
           b=c("jim, John"), 
           c=list(first= list(1,"a"), 
                  second=list(2,"b"))
)
what_is_it(x4)
#, max.level=2, vec.len=2)

x3 <- "this is a string"
what_is_it(x3)  # characer vector, length 1

# letters
typeof(letters)
letters
what_is_it(letters)  # character vector, length 26

# ---- naming elements of vector

# 1
z<-c(x=1,
  y="b",
  c=TRUE)
z[1]
z[x] # fails
z["x"]

names(z)
names(z)[2]
set_names(names(z)[2]="newName")

# a hold atomic vector of ints, string (char), scaler double, list
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))

# subset, will always be another list, can do by int, char, logical
a[2]
is_list(a[2]) #T
a[b] #fail
a["b"]
a[c(FALSE,TRUE,FALSE,FALSE)] # pulls out 2nd element in list a


## [[]] returns contents
a[[1]]
is_list(a[[1]]) # F
is_vector(a[[1]]) #T
is_atomic(a[[1]]) #T
is_integer(a[[1]]) # T

a[[1]][2]  # 1st list, 2nd element
a[[1]][3]  # 1st list, 3


a[1]
a["a"]
a[1][2] # fails
a[[1]]

