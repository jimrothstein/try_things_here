#  014_maps_choroplethr.R

# see
# https://www.arilamstein.com/open-source/

library(choroplethr) # based on rdal, which based on gdal and needs
#       gdal version >= 2.0.0 .  R respositiory only has gdal 1.11.3
?df_pop_state
data(df_pop_state)

state_choropleth(df_pop_state, title="2012 US State Population Estimates", legend="Population")
