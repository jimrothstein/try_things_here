## 096_base_R_control_misc.R

# ============
## Structure
# ============
## non-binary
y  <- list(a=1, b=2)
dput(y)

# keeps meta data
dput(mtcars[1,])
structure(y)

## for binary
## saveRDS


# ======================
## if - else if - else
# ======================

f  <- function(x) {
	if (x <0) {cat("less than 0")}
	else if(x<1) {cat("less than 1")}
	else if(x<2) {cat("less than 2")}
	else if(x<3) {cat("less than 3")}
	else if(x<4) {cat("less than 4")}
	else {cat("4 or greater")}
}

x <- -1
f(x)
f(x <- x+1)
f(x  <- x+1)
f(x  <- x+1)
x
