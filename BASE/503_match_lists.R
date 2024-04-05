##  Purpose:  For vector, find element positions, repeats, etc.
## 503_match_lists.R
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}


ex <- c(letters[1:3], "a")
unique(ex)

match(ex, unique(ex)) # vector of positions (1st position)

tabulate(match(ex, unique(ex))) # counts integers (only)
m <- which.max(tabulate(match(ex, unique(ex)))) # counts integers (only)
ex[m]


Mode(ex)
