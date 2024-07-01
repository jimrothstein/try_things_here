##  Purpose:  
##  BASE:  For simple vector, find element positions, repeats,  matches etc.

## 503_base_simple_vectors.R

### simple, ordered


# ------------------------
# create char vector:   
# -----------------------
letters[1:5]
x=c(letters[1:5], "a")

# -------------------
## strsplit  - break up 'words' into individual charcters
# -------------------
z="abcd"
y=unlist(strsplit(z, split=""))
y
# --------------------------------------
# match(find this, source) # returns first index
# --------------------------------------
match("b", c("a", "b", "c")) # [1] 2
match("a", x) # [1] 1

match("a",
     x)

lm(
# ---------
# ---------
### subset,  
# ---------
# ---------
x[x == x[1]] # [1] "a" "a"

# here, [ and [[ result in same
identical(x[x == x[1]], x[x == x[[1]]])


x[x == x[c(1,2)]] # [1] "a" "b"
x[x > "b"] # [1] "c" "d" "e"

# logical
duplicated(x)

#
unique(x)

any("a" == x)
any(c("a", "b", "z") == x)

## unlike match, which creturns  index of all matches
which(x == "a")
# to limit:
which(x == "a")[[1]]

which(x == "b")
which(x == c("a", "b"))

# error, not for char
which(x == "a"|"b")

