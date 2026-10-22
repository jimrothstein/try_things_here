# 010_break_up_string.R

# PURPOSE:   Given string s, break in pieces of length K+1, begin at from=
#             Note:  R count begins at 1
library(testthat)
s <- LETTERS
L <- length(s)
K <- 3

get <- seq(from = 1, to = K + 1)
s[get]

```R
get <- seq(from = 4, to = K + 4)
s[get]
```


piece <- function(s, K = 3, start = 1) {
  ind <- seq(from = start, to = K + start)
  s[ind]
}

piece(s)

piece(s, start = 2)

> [!NOTE]  
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]  
> Crucial information necessary for users to succeed.

> [!WARNING]  
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.

testthat::expect_equal(piece(s, start = 1), LETTERS[1:4])
testthat::expect_equal(length(piece(s, start = 2)), 4)
