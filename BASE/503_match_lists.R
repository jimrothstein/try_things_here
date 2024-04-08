##  Purpose:  
##  BASE:  For simple vector, find element positions, repeats,  matches etc.

## 503_match_lists.R

##  

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
# match(find this, source) # returns index
# --------------------------------------
match("b", c("a", "b", "c")) # [1] 2
match("a", x) # [1] 1

# ---------
# ---------
subset,  
# ---------
# ---------
x[x == x[1]] # [1] "a" "a"
x[x == x[c(1,2)]] # [1] "a" "b"
x[x > "b"] # [1] "c" "d" "e"

duplicated
unique
any
which

