REF:    see  Index card #142
        see  https://stackoverflow.com/questions/49911087/r-nested-list-to-tibble 

##  PURPOSE:    sequences (1, 2, 3, ...)
#   NOTE:       USE seq_along, seq_len;  primitives  not seq(),  a generic which has bug related to 1:0

- seq
- seq_along()

##  seq is a bit inconsistent, sometimes `from` to `and` sometimes sequence based
##  upon length of input  , it is generic
```{r}


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

```



##  seq_along (object)
```{r}


# Givn an arg, 
# finds length of argument, generate sequence that long
x  <- NULL
d  <- NULL


seq_along(c(sin, cos, tan )) # [1] 1 2 3

seq_along(pi)  # pi is just 1 elment # [1] 1
seq_along(rep(pi, 7))  # [1] 1 2 3 4 5 6 7

L=list("a", "b")

for (i in seq_along(L)) { print(L[[i]])}
```


## seq_len (integer)
# input is int, length 1,  returns sequence of length equal to integer input 
```{r}
seq_len(4)  # 4
seq_len(x)  # it is confused!
seq_len(length(x))
```
##  lengths - plural
```{r}
l = list(letters[1:3], letters[4:8])    # lengths 3, 5 
lengths(l) # [1] 3 5
```

##  sequence( nvecs, )  multiple sequences, one for each integer in  nvecs
```{r}
sequence(lengths(l)) # [1] 1 2 3 1 2 3 4 5
sequence(1:4) #  [1] 1 1 2 1 2 3 1 2 3 4
```

