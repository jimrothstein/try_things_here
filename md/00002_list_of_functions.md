## vim:linebreak:nowrap:nospell:cul tw=78 fo=tqlnr foldcolumn=3

# Spaces, no Tabs

title: Template for .Rmd date: “last updated 11:07, 06 June 2021”
output: pdf\_document: latex\_engine: xelatex toc: TRUE toc\_depth: 1
fontsize: 12pt geometry: margin=0.5in,top=0.25in —

<!-- 
vim: to format all urls for md
s/https.*/[&]()/g
-->

------------------------------------------------------------------------


    ##  IDEA is to pick correct fix_function based on param's name.
    ## Then apply the function to param's value.
    ## Repeat for all the parameters.

    # fake data
    raw_params  <- list(pm1 = "A", pm2 ="B" , pm3 ="C")

    #   GOAL:     input_params:   list (pm1 = "1A", pm2 = "2B", pm3 = "3C")

    # helps to separate into two vectors, param names & values
    names(raw_params )  # char
          ## [1] "pm1" "pm2" "pm3"
    values  <- unlist(raw_params)  
    values
          ## pm1 pm2 pm3 
          ## "A" "B" "C"


    # match each param to fix function
    fix_funs  <-  list( pm1 = function(x) paste0("1",x),
                        pm2 = function(x) paste0("2",x),
                        pm3 = function(x) paste0("3",x)
                        )
    fix_funs
          ## $pm1
          ## function(x) paste0("1",x)
          ## <environment: 0x555f15e31ef8>
          ## 
          ## $pm2
          ## function(x) paste0("2",x)
          ## <environment: 0x555f15e31ef8>
          ## 
          ## $pm3
          ## function(x) paste0("3",x)
          ## <environment: 0x555f15e31ef8>


    # given param, return its fix function
    pick_function  <- function(name = x) {
      fix_funs[[name]]
    }


    # TWO-steps, get right fix function (based on param name), then apply to value 
    input_params  <- map2(values, names(raw_params),
                         ~ pick_function(.y)(.x)) 
          ## Error in map2(values, names(raw_params), ~pick_function(.y)(.x)): could not find function "map2"
    # matches GOAL
    input_params
          ## Error in eval(expr, envir, enclos): object 'input_params' not found

    knitr::knit_exit()
