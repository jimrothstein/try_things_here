# 011_dplyr_windows_Lahman

# see: 'windows vignette'
#  http://dplyr.tidyverse.org/articles/window-functions.html
# 

# Tags:   Lahman, dplyr

# ---- prelim
library(Lahman)
lahman_


# ---- examine
batting <- Lahman::Batting # 101,332 x 22
awards  <- Lahman::AwardsPlayers

str(batting)    # (playerID*, yearID* , stint, teamID* , lgID*)
str(awards)     # 6078 x 6  (playerID*, awardID*, yearID*, lgID*)



# semi-join, keep x ONLY IF matching y
batting <- Lahman::Batting %>%
        as_tibble() %>%
        select(playerID, yearID, teamID, G, AB:H) %>%
        arrange(playerID, yearID, teamID) %>%
        semi_join(Lahman::AwardsPlayers, by = "playerID")
batting         # 19,113 x 7


# players seems same as batting
players <- batting %>% group_by(playerID)   # 19,113 x 7
players

anti_join(batting, players) # no rows
distinct(players)   #   hmmmm, find unique ROWS,
distinct(players, playerID)     #1332 x 1, much better

# ---- 
# For each player, find the two years with most hits (seems no order)
# min_rank subsets WITHIN a group
filter(players, min_rank(desc(H)) <= 2 & H > 0)  # 2,697 x 7

# Within each player, rank each year by the number of games played
mutate(players, G_rank = min_rank(G)) 

# TODO(jim: repeat but arrange, for each player, G_rank, in desc order)

# %>% arrange(playerID, yearID, G, desc(G_rank))

# For each player, find every year that was better than the previous year
filter(players, G > lag(G))
# For each player, compute avg change in games played per year
mutate(players, G_change = (G - lag(G)) / (yearID - lag(yearID)))

# For each player, find all where they played more games than average
filter(players, G > mean(G))
# For each, player compute a z score based on number of games played
mutate(players, G_z = (G - mean(G)) / sd(G))
