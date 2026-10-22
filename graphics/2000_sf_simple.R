library(sf)
library(tidyverse)
demo(nc, ask = FALSE, echo = FALSE)
plot(st_geometry(nc))

wyoming <- read_sf("https://data.rfortherestofus.com/wyoming.geojson")
wyoming


wyoming %>%
  ggplot() +
  geom_sf()
x
