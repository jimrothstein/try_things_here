https://leetcode.com/problems/longest-substring-without-repeating-characters/description/


# substring can begin anywhere

  # table = string
  # x char to match


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
rem  <- cut(z, index)                          #remainder 
rem

# for character at position, is there a match LATER in str?
find  <- function(z[[index]], rem)
if ( z[[index]] %in% rem ) # dup found
{
  # return position
  match(z[[index]], rem)
}

