library(mathlib)

x1 <- c(0, 0)
x2 <- c(1, 4)
pointOnLine(x1, x2, 0.5)
pointOnLine(x1, x2, 0.5, absolute=FALSE)
pointOnLine(x1, x2, 1.1)

y1 <- c(1, 2, 3)
y2 <- c(3, 2, 1)
pointOnLine(y1, y2, 0.5)
pointOnLine(y1, y2, 0.5, absolute=FALSE)


remotes::install_github("friendly/matlib", build_vignettes = TRUE)

