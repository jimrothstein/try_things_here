#!/usr/bin/env Rapp
#| description: Flip a coin.

#| description: Number of coin flips


# Rapp runs code at shell (not console)
# https://github.com/r-lib/Rapp
n <- 1L

cat(sample(c("heads", "tails"), n, TRUE), fill = TRUE)
