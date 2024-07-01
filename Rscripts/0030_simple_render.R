#!/usr/bin/env Rscript
#
#
#
#
#
library(rmarkdown)
library(knitr)
library(here)
print("hello")
Sys.time()


file <- "~/code/try_things_here/rmd/00002_glue.Rmd"


# getwd() - need to careful;   run as script it thinks Rscripts/ is wd
rmarkdown::render(file,
  output_format = c(
    "html_document", # if want both
    "md_document",
    "pdf_document"
  ),
  output_dir = "~/code/try_things_here/out",
  output_file = "out"
)
