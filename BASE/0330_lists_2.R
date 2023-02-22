# BASIC:   SEE 0320_
# ------------------------------
#     Compare X,Y, Z   - all different
# ------------------------------
#
# # not even a list!
X = list(A=list(),
  x="a",
  y="b",
  )

Y = list(A=list(),
  B=c(x="a", y="b"))
Y
str(Y)
# List of 2
#  $ A: list()
#  $ B: Named chr [1:2] "a" "b"
#   ..- attr(*, "names")= chr [1:2] "x" "y"
# NULL

Z = list(A=list(),
          B=c(x="a"), 
  C=c(y="b")
)
Z
str(Z)
# List of 3
#  $ A: list()
#  $ B: Named chr "a"
#   ..- attr(*, "names")= chr "x"
#  $ C: Named chr "b"
#   ..- attr(*, "names")= chr "y"
# NULL

