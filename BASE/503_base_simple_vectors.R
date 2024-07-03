##  Purpose:  
##  BASE:  For simple vector, find element positions, repeats,  matches etc.

## 503_base_simple_vectors.R

#' verbs included:
#' strsplit, unlist, match, unique, any, all, which, in

### simple, ordered

# HELPER

#' create simple character vector, individual characters
create_s = function() {
  v=c(letters[1:10], "a")
  unlist(strsplit(v, split=""))
}
s = create_s()         
s

        

# -------------------
## strsplit  - break up 'words' into individual charcters
# -------------------
# --------------------------------------
# match(find this, source) # returns first index
# --------------------------------------
match("a", s)
match("b", s)

s[s == s[1]] # [1] "a" "a"

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

## insert 

# https://leetcode.com/

library(styler)
styler::style_file(".")

styler::style_file(
  "~/code/try_things_here/leetcode/010_longest_using_simple_vector.R"
)

# HELPER functions

# -----------------
##  String verbs
# -----------------

#' create a string.
#' create_s
#' @return character vector

create_s <- function() {
  v <- c(letters[1:10], "a")
  v <- unlist(strsplit(v, split = ""))
}

s <- create_s()

length(s) # [1] 6
unique(s) # [1] "A" "B" "C" "D" "E"
duplicated(s) # [1] FALSE FALSE FALSE FALSE FALSE  TRUE
match(s, table = "A")
match("A", s) # first match [1] 1

# Recall:  x or text are char[] character vectors
substr(x = "abcde", 2, 4) # [1] "bcd"
substr(x = c("abcde", "12345"), 2, 4) # [1] "bcd" "234"
substr(paste0(letters, collapse = ""), 2, 4) # [1] "bcd"

# none of elements of char[] text have more than 1 character
substring(text = LETTERS[1:5], 2, 4) # [1] "" "" "" "" ""
substring(paste0(letters, collapse = ""), 2, 4) # [1] "bcd"
substring(c(paste0(letters, collapse = ""), "ABCDE"), 2, 4) # [1] "bcd" "BCD"


# substring can begin anywhere

# -----
# CUT  1 char at position n
# -----

#' @param x vector, each element must be char[1]
#' @param n integer position to remove
#' @return vector with one element removed
cut <- function(x, n) {
  # be sure individual characters
  stopifnot(n <= length(x))
  x[-c(n)]
}

# test
str <- c("abca")
z <- unlist(strsplit(str, ""))

# remove character, get remainder
index <- 1
rem <- cut(z, index)
rem # remainder

# ----------------------------------------------
#  LATER MATCH?  given char at  position index
# ----------------------------------------------
# for character at position, is there a match LATER in str?

# t or f
find <- function(s, X) s %in% X # dup found

find("a", X)
find("z", X)


# stops after 1st match
match("a", X)

###  Given a string, break into single letters

string <- c(letters[1:10], "a")
X <- unlist(strsplit(string, split = ""))
X
N <- length(X)
Y <- character(N)


### Does X[[1]] have match?
which(X[[1]] == X[2:N])

# yes, positions 1, 11
which(X[[1]] == X)

X[2:N]

### Reverse letters
for (i in 1:N) {
  Y[i] <- X[N + 1 - i]
}
Y

##



X <- create_s()
X

for (i in 1:11) print(X[[i]])

any(X == "a")
all(X == "a")

X[X == "a"]
