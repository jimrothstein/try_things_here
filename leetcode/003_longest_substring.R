https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
# TODO
# - REGEX?

# -----------------
  ##  PRELIMINARY
# -----------------
  Given a string s = c(LETTERS[1:5], LETTERS[1])
  s = c(LETTERS[1:5], LETTERS[1])
length(s) # [1] 6
unique(s) # [1] "A" "B" "C" "D" "E"
duplicated(s) # [1] FALSE FALSE FALSE FALSE FALSE  TRUE
match(s, table= "A")
match("A",  s)  # first match [1] 1

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
find  <- function(z[[index]], rem)
if ( z[[index]] %in% rem ) # dup found
{
  # return position
  match(z[[index]], rem)
}

