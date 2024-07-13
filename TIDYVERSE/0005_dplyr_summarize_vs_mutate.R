# 005_dplyr_summarize_vs_mutate.R

# 00-Info -----------------------------------------------------------------

# See: 
# http://www.win-vector.com/blog/2017/07/better-grouped-summaries-in-dplyr/

# Confused, seems that both work
# Author seems to suggest mutate sometimes WILL NOT work, must review  SQL
# dplyr::summarize creates a NEW df, 1 row for each grouping

# Tags: summarize vs mutate


# 00-Setup---------------------------------------------------------------------
suppressPackageStartupMessages(library('dplyr'))
packageVersion("dplyr") # 1.1.4

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


##  use .data pronoun; summarize returns new tibble
mtcars |>
  dplyr::group_by(.data$gear) |>
  dplyr::summarise(round_cyl = round(mean(.data$cyl)


                                     ## Using R expressions

'pipe_to_round' = { 
mtcars |>
    dplyr::group_by(.data$gear) |>
    dplyr::summarise(round_cyl = mean(.data$cyl)) |> round(2)
}
eval(pipe_to_round)


z  = { 
mtcars |>
    dplyr::group_by(.data$gear) |>
    dplyr::summarise(round_cyl = mean(.data$cyl)) |> round(2)
}

is.expression(z)

'no_rules' = {

mtcars |>

  dplyr::summarise(

    round_cyl = {

      .data$cyl |>

        mean() |>

        round(2)

    },

    .by = 'gear'

  )

}
'no_rules'
is_expression('no_rules')
eval('no_rules')
eval(no_rules)
