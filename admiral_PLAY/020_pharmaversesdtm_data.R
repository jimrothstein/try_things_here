## PURPOSE:
## Sample sdtm datasets  become sample adam datasets (via Admiral)
## loaded packages
search()

# also loads ae and datasets
library(pharmaversesdtm)

search()
ls()

ls()

## all  loaded datasets, ordered by package
data()

## all datasets for specific package
data(package = "pharmaversesdtm")

## names for any specific dataset 
names(ae)
names(dm)

# type name
sv
smq_db

tr_onco

# ------------------------------
library(pharmaverseadam)
data(package="pharmaverseadam")

## Vital Signs Analysis
names(advs)
str(advs)
is.data.frame(advs)

vs
library("admiral")
data(package="admiral")

dim(admiral_adsl)
nrow(admiral_adsl)

# vs missing data?
names(vs)
vs$VSTPTREF

admiral_adsl


#
data(vs)
data(admiral_adsl)
# ------------------------------
library(glue)
glue::glue("a = 3", "\n", "b=3", "\n")
?pharamverseadam
