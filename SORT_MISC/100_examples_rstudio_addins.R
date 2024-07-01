##  PURPOSE:    try 3rd party Addins


##  devtools::install_github("rstudio/addinexamples", type = "source")
##  position cursor on "function"
##  with remap of Alt + 2 applies reshape
foo <- function(a, b, c) {
  NULL
}

##  position cursor on "list"
##  run `addin Reshape Expression`, Alt + 2
list(
  a = 1,
  b = list(2, 3)
)
