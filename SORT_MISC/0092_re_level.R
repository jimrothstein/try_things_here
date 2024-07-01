# 092_re_level.R

#### function Details
# =====================
# HERE - some progress
details <- function(x) {
  cat(" ====== ", "\n")
  cat("internally x = ", x, "\n")
  cat("x is factor ", is.factor(x), "\n")
  cat("x is vector ", is.vector(x), "\n")
  cat("x is ordered", is.factor(x), "\n")
  cat("x is character", is.character(x), "\n")
  cat("x is typeof ", typeof(x), "\n")
  cat("x is class", class(x), "\n")
  cat("levels(x) = ", levels(x), "\n", "\n")
  cat("labels(x) = ", labels(x), "\n", "\n")

  cat("sort(x) = ", sort(x), "\n", "\n")
  cat("str(x) = ", str(x), "\n", "\n")
  cat("attributes(x)$levels = ", attributes(x)$levels, "\n", "$class ", attributes(x)$class, "\n")
}


# return char[] , length 100
v <- sample(letters[1:5], 15, replace = TRUE)
details(v)

v <- factor(v)
v
details(v)

# now order it, suprise defalt is lexical order
sort(v)

# work with levels, returns char[]
levels(v) # same as above:  looks like "a" "b" ....


# BUT permute
# new level 1, use old 4, levels(v)[4]
# new level 2, use old 5

# use INDEX   <- --- Trick!
new_levels <- levels(v)[c(4:5, 1:3)]
new_levels

# 2 ways to reset levels
levels(v) <- new_levels


# or
v <- factor(v, levels(v)[c(4:5, 1:3)])

# FINALLY
sort(v)

## CHANGE how displayed:   LABELS
labels(v)
v
# chaange the LABELS?!
new_labels <- c("I", "II", "III", "IV", "V")
v1 <- factor(v, labels = new_labels)
labels(v1)
v1

# BUT
sort(v1) # back to lexial order
