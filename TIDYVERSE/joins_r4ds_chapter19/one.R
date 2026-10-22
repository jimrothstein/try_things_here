library(tidyverse)
library(nycflights13)


flights2 <- flights |> 
  select(year, time_hour, origin, dest, tailnum, carrier)
names(flights2)

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
# all rows in x only, but with a match in y 
Z1=airports |> 
  semi_join(flights2, join_by(faa == origin))
Z1
nrow(Z1) #3
flights2

flights2 |> 
  anti_join(airports, join_by(dest == faa)) |> 
  distinct(dest)
 
# Exercise 19.3.4
# 1   worst delays?
flights
names(flights)
worst = flights |> arrange(desc(arr_delay)) |> select(month, day, arr_delay)
(worst = flights |> arrange(desc(dep_delay)) |> select(month, day, arr_delay)) |> head(n=20 )
worst

weather |> dplyr::filter( month == 7 & day==22) |> head()

weather |> dplyr::filter( month == 12 & day==16) |> head()

weather |> arrange(desc(precip)) |> head(n=20)
weather |> arrange(origin, month, day) |> count(origin, month,day) |> dplyr::filter(n != 24)
