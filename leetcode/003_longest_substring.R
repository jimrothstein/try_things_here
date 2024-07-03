# https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
# TODO
# - REGEX?

## TODO:
## This file should contain code to find longest substring.
## For code related to varius character vector manipulations:  SEE BASE/503_

# -----------------
  ##  String verbs
# -----------------
  Given a string s = c(LETTERS[1:5], LETTERS[1])
  s = c(LETTERS[1:5], LETTERS[1])
length(s) # [1] 6
unique(s) # [1] "A" "B" "C" "D" "E"
duplicated(s) # [1] FALSE FALSE FALSE FALSE FALSE  TRUE
match(s, table= "A")
match("A",  s)  # first match [1] 1

# Recall:  x or text are char[] character vectors
substr(x="abcde", 2,4) # [1] "bcd"
substr(x=c("abcde", "12345"),  2,4) # [1] "bcd" "234"
substr(paste0(letters, collapse = ""), 2, 4) # [1] "bcd"

# none of elements of char[] text have more than 1 character
substring(text=LETTERS[1:5],2,4) # [1] "" "" "" "" ""
substring(paste0(letters, collapse = ""), 2, 4) # [1] "bcd"
substring(c(paste0(letters, collapse = ""), "ABCDE"), 2, 4) # [1] "bcd" "BCD"


# substring can begin anywhere

  # table = string
  # x char to match

# -----
# CUT  1 char at position n
# -----

@param x vector, each element must be char[1]
@param n integer position to remove
@return vector with one element removed
cut  <- function(x, n){
  # be sure individual characters
  stopifnot( n <= length(x))
  x[-c(n)]
}

# test
str = c("abca")
z= unlist(strsplit(str, ""))

# remove character, get remainder
index = 1
rem  <- cut(z, index); rem                          #remainder 

# ----------------------------------------------
#  LATER MATCH?  given char at  position index
# ----------------------------------------------
# for character at position, is there a match LATER in str?

# t or f
find  <- function(s, X) s %in% X  # dup found

find("a", X)
find("z", X)


# stops after 1st match
match("a", X)

###  Given a string, break into single letters

string = c(letters[1:10], "a")
X=unlist(strsplit(string, split=""))
X
N=length(X)
Y=character(N)


### Does X[[1]] have match?
which(X[[1]] == X[2:N])

# yes, positions 1, 11
which(X[[1]] == X)

      X[2:N]

### Reverse letters
for (i in 1:N) {
Y[i] =X[N+1 - i]
}
Y

