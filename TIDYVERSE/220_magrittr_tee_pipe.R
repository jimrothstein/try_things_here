## 220_magrittr_tee_pipe.R

## PURPOSE:        demo magrittr `%T>%` pipe
##                      unlike `%>% this fowards input on
##                      %T>% is a FUNCTION

z <- rnorm(200) %>%
  matrix(ncol = 2) %>%
  plot() # plot usually does not return anything.
z


##      `%T%`(matrix,plot)  and returns the matrix (to next step in chain)
rnorm(200) %>%
  matrix(ncol = 2) %T>%
  plot %>% # plot usually does not return anything.
  colSums()

##      Study carefully:  plot here argument to `%T>%`
rnorm(200) %>%
  matrix(ncol = 2) %T>%
  plot %>%
  print() # plot usually does not return anything.

##  Use explicitly as function
`%T>%`(rnorm(200) %>% matrix(ncol = 2), plot) %>%
  print() # plot usually does not return anything.
library(cli)
finaldataset <- mtcars %T>%
  {
    gas_guzzler <<- dplyr::filter(., mpg > 30)
    nguzzler <<- nrow(gas_guzzler)
  } %T>%
  {
    if (nguzzler < 10) {
      cli_inform(c("I have found a few cars.", "{nguzzler} to be exact!"))
    } else {
      cli_inform(c("I have found {nguzzler} and that's a lot!"))
    }
  } %>%
  group_by(gear) %>%
  summarize(car_count = n())
