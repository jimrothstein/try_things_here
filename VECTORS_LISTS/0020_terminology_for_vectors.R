f #  Terminology
##
##  integer vector
c(1, 2, 3)


##  character vector (not `atomic chracter vector ` )
c(letters[1:5])

##  raw vector?   (HEX)
as.raw(c(0, 1, 2, 254, 0xc0))
# [1] 00 01 02 fe c0
#
charToRaw("a")
sapply(letters[1:15], charToRaw)
#  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o
# 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f



x <- 1 / 0
# [1] Inf
