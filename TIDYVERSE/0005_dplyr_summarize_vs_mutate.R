# 005_dplyr_summarize_vs_mutate.R

# 00-Info -----------------------------------------------------------------

# See: 
# http://www.win-vector.com/blog/2017/07/better-grouped-summaries-in-dplyr/

# Confused, seems that both work
# Author seems to suggest mutate sometimes WILL NOT work, must review  SQL

# Tags: summarize vs mutate


# 00-Setup---------------------------------------------------------------------
suppressPackageStartupMessages(library('dplyr'))
packageVersion("dplyr") # 0.7.0

# 0-summarize --- Works as expected 8 x 4
mtcars %>%
        group_by(cyl,gear) %>%
        summarise(mean_mpg = mean(mpg),
                  mean_disp = mean(disp)) 

# 0-mutate --- ALL fields & data display     -------------------------------------------
mtcars %>% 
        group_by(cyl,gear) %>%
        mutate(mean_mpg = mean(mpg),
               mean_disp = mean(disp)) 
#

# 1 mutute, shortcut ---  ALL fields & data displays    ---------------------------------------------------------------

mtcars %>% 
        group_by(cyl,gear) %>%
        mutate(mean_mpg = mean(mpg),
               mean_disp = mean(disp)) %>%
        select(cyl, gear, mpg, disp,
               mean_mpg, mean_disp)

# 2 summarise ---------------------------------------------------------------

# TODO(jim: left_join is not correct join)
# left_join includes all rows from mtcars in result 
# summarize returns 1 row for each grouping
mtcars %>%
        group_by(cyl,gear) %>%
        summarise(mean_mpg = mean(mpg),
                  mean_disp = mean(disp))  %>%
        left_join(mtcars, ., by = c ('cyl', 'gear')) %>%
        select(cyl, gear, mpg, disp, 
               mean_mpg, mean_disp)
        


# 3 correct way, see #0  -------------------------------------------------------------

mtcars %>%
        group_by(cyl,gear) %>%
        summarise(mean_mpg = mean(mpg),
                  mean_disp = mean(disp)) %>%
        select(cyl, gear, 
               mean_mpg, mean_disp)

# 4 simplest? -------------------------------------------------------------

mtcars %>% 
        group_by(cyl,gear) %>%
        mutate(mean_mpg = mean(mpg),
               mean_disp = mean(disp)) %>%
        select(cyl, gear, mpg, disp,
               mean_mpg, mean_disp)

#
        dplyr::show_query()


