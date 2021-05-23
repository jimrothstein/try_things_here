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


file  <-  "~/code/try_things_here/rmd/00002_glue.Rmd"

rmarkdown::render(file,

                  output_format=c("html_document",    # if want both
                                  "md_document",
                                  "pdf_document"),
                  output_dir = "out",
                  output_file = "out")
