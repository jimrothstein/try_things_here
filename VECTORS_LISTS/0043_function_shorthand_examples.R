
---
title: "`r knitr::current_input()`"
date: "`r paste('last updated', 
    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: show
        toc: true 
        toc_depth: 4
        toc_float: true
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  4   
fontsize: 11pt   
geometry: margin=0.4in,top=0.25in   
TAGS:  regression
---
~/code/MASTER_INDEX.md
file="/home/jim/.config/nvim/templates/skeleton.R"

# R
#
#

sapply(c(1,2,3), function(x) x+1)
# [1] 2 3 4
#
##  As of R v4.1.1
sapply(c(1,2,3), \(.) . + 1)
sapply(c(1,2,3), \(x) x + 1)
