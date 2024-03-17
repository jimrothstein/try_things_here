library(tidyverse)
library(rlang)

DATA <- structure(list(Year = c(2015, 2015, 2015, 2015, 2015, 2016, 2016, 
                                2016, 2016, 2016), X = c("Dissatisfied", "Dissatisfied", 
                                                         "Dissatisfied", "Dissatisfied", "Dissatisfied", "Satisfied", 
                                                         "Dissatisfied", "Dissatisfied", "Satisfied", "Dissatisfied")), class = "data.frame", row.names = c(NA, 
                                                                                                                                                            -10L))


my_function <- function(data=DATA, x=X, cols = vars(Year)){
  
  ggplot(data) +
    aes(x= !!ensym(x), 
        y=after_stat(count)/ sapply(PANEL, \(x) sum(count[PANEL == x])) , 
        fill=ifelse( round(after_stat(count)/ sapply(PANEL, \(x) sum(count[PANEL == x])) * 100, 2) < 5| 
                                      round(after_stat(count)/ sapply(PANEL, \(x) sum(count[PANEL == x])) * 100, 2) > 95, "white"
                                    , "fill")) +
    geom_bar()  +
    facet_grid(cols=cols) +
    theme(legend.title=element_blank())
  
}
###### EXAMPLE OF USE:
my_function()

library(data.table)
dt <- data.table(v1 = c("1","2", "3", NA))
dt %>%
  mutate( v2 = dplyr::case_when(is.na(v1) ~ "0",
                         TRUE ~ v1))
dt[ , v2 := fcase(
  is.na(v1), "0",
  !is.na(v1), v1)
]
dt
