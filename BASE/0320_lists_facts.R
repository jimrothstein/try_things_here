# ------------------------------
#     Compare X,Y  both are lists with 1 element, ....but
# ------------------------------
str(c(1,2))
#  num [1:2] 1 2
# NULL
#
#
#
# X is list 
X = list(list(1,2))
X
str(X)
# List of 1
#  $ :List of 2
#   ..$ : num 1
#   ..$ : num 2
# NULL
#
# Y is a list containing ONE element
Y = list(c(1,2))
Y
str(Y)
# List of 1
#  $ : num [1:2] 1 2
# NULL

identical(X,Y)
# [1] FALSE



Z = list(list(c(1,2)))
Z
str(Z)
# List of 1
#  $ :List of 1
#   ..$ : num [1:2] 1 2
# NULL
identical(X,Z)
identical(Y,Z)

# ------------------------------
#
# ------------------------------
##  2nd list,  has 1 element
X <- list(list(letters[1:5])) 
str(X)

##  lists do not need `attribute`
attributes(X)
# NULL


unlist(X)
# ------------------------------
