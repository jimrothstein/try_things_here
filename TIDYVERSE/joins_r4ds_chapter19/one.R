library(tidyverse)
library(nycflights13)

## unique?
planes |> count(tailnum) |> dplyr::filter(n>1)

flights
flights$flight
flights|> count(flight)
sort(flights$flight) |> head()
names(flights)

airports
airports |> count(lat) |> arrange(desc(n))
airports |> count(lat, lon) |> arrange(desc(n))


(flights2 = flights |> mutate(id = row_number()))
(flights2 = flights |> mutate(id = row_number(), .before=1))

names(weather)
weather |> select(c(origin, time_hour, visib, precip,  wind_gust ))

airports |> select(1:4)

flights2 |> select(id, 1:6)


# 19.3
flights2 <- flights |> 
  select(year, time_hour, origin, dest, tailnum, carrier)

flights2
nrow(flights2)
ncol(flights2)

airlines
nrow(airlines)
ncol(airlines)

# joins
X = flights2 |> left_join(airlines)
X
nrow(X)
ncol(X)


# clearest
flights2 |> left_join(airlines, join_by(carrier == carrier))

flights2 |> semi_join(airlines, join_by(carrier == carrier))

# flights2 contains departures ONLY from NY area
Z =  airports |> 
  left_join(flights2, join_by(faa == origin))
nrow(Z) # 338,231



# rule row must be in both x and y
Z1=airports |> 
  semi_join(flights2, join_by(faa == origin))
Z1
nrow(Z1)
flights2
