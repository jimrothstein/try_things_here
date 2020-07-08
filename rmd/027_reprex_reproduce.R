# 027_reprex_reproduce.R

# 
# TO PASTE in vim
#		Run code
#		Paste:  "+p
# ==============
#
## Method 1
# ===========
library("reprex")

(y <- 1:4)
mean(y)

## results in console and clipboard.
reprex()


## Method 2 (prefer)
# ====================

## reprex in .Rprofile (workflow pkgs are OK to put in .Rprofile)
## not RUN
## usethis::edit_r_profile()

# copy to clipboard
# no need to run
(y <- 1:4)
mean(y)

stop("in console, run reprex()")
## then run:
## clipboard now has results
# not run
#reprex()

# works (ie sent to clipboard)
reprex({
	print ("hi")
})

#### METHOD 3:   BEST  ####
# ===========================

# ---- Example -----
# works
# run code, enclosed in reprex
# result put into clipboard
r <- reprex( {
	x <- 1:4
	y  <- 2:5
	x+y
}, venue="R")

# Then paste from clipboard, yields:
x <- 1:4
y  <- 2:5
x+y
#> [1] 3 5 7 9

r
# ---- -----

# SESSIONINFO
# =============
#	si=TRUE includes session_info()
r  <- reprex({
	x     <- 1
	x }, si = TRUE)
