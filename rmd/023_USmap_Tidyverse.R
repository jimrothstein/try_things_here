# 023_USmap_Tidyverse.R


?map_data()
library(tidyverse)


# ---- 001-US map ----
# MAP USA
map_data("usa") %>% 
        ggplot(aes(x = long, y = lat, group = group)) +
        geom_polygon()
m <- map_data("usa")
m
nrow(m)  #7243
dim(m)   #7243 x 6


