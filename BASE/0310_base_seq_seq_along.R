# USE seq_along, seq_len; primitives  not seq,  a gernic

##  seq is a bit inconsistent, sometimes `from` to `and` sometimes sequence based
##  upon length of input  , it is generic
seq(0,10,1)
seq(0,1, .1)
seq(0:2)
seq(c(0,1))

##  not expected
##
seq(0)   # ??
seq(1)
seq(3)
seq()
seq(NULL)
seq(NA)





# Givn an arg, 
# finds length of argument, generate sequence that long
x  <- NULL
d  <- NULL
seq_along(x)
seq_along(d)

seq_along(pi)  # pi is just 1 elment
seq_along(rep(pi, 7))  # lenght =7, generate 7 elemnts

# input is int, length 1,  returns sequence of length equal to integer input 
seq_len(4)  # 4
seq_len(x)  # it is confused!
seq_len(length(x))




