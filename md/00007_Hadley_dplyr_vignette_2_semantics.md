**PART 2 of basic dplyr article (hadley)** Starts with “Patterns of
Operations” see:
<https://dplyr.tidyverse.org/articles/dplyr.html#patterns-of-operations>
\#\#\#\# 00-initialize

    #rmarkdown::render("./007_Hadley_dplyr_vignette_2_semantics.Rmd",output_dir = "./plots/")

    # Choose one:

    ## prints source only,  no eval
    #knitr::opts_chunk$set(echo = TRUE, eval=FALSE)

    ## print source, results and print errors, but do not stop
    knitr::opts_chunk$set(echo = TRUE, error=TRUE)

#### 01-setup

    library(tidyverse)

    ## ── Attaching packages ──────────────────────────────── tidyverse 1.3.1 ──

    ## ✔ ggplot2 3.3.3     ✔ purrr   0.3.4
    ## ✔ tibble  3.1.2     ✔ dplyr   1.0.6
    ## ✔ tidyr   1.1.3     ✔ stringr 1.4.0
    ## ✔ readr   1.4.0     ✔ forcats 0.5.1

    ## ── Conflicts ─────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ purrr::%@%()         masks rlang::%@%()
    ## ✖ purrr::as_function() masks rlang::as_function()
    ## ✖ dplyr::collapse()    masks glue::collapse()
    ## ✖ dplyr::filter()      masks stats::filter()
    ## ✖ purrr::flatten()     masks rlang::flatten()
    ## ✖ purrr::flatten_chr() masks rlang::flatten_chr()
    ## ✖ purrr::flatten_dbl() masks rlang::flatten_dbl()
    ## ✖ purrr::flatten_int() masks rlang::flatten_int()
    ## ✖ purrr::flatten_lgl() masks rlang::flatten_lgl()
    ## ✖ purrr::flatten_raw() masks rlang::flatten_raw()
    ## ✖ purrr::invoke()      masks rlang::invoke()
    ## ✖ dplyr::lag()         masks stats::lag()
    ## ✖ purrr::list_along()  masks rlang::list_along()
    ## ✖ purrr::modify()      masks rlang::modify()
    ## ✖ purrr::prepend()     masks rlang::prepend()
    ## ✖ purrr::splice()      masks rlang::splice()

    library(nycflights13)
    flights %>% glimpse()

    ## Rows: 336,776
    ## Columns: 19
    ## $ year           <int> 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2…
    ## $ month          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ day            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ dep_time       <int> 517, 533, 542, 544, 554, 554, 555, 557, 557, 558,…
    ## $ sched_dep_time <int> 515, 529, 540, 545, 600, 558, 600, 600, 600, 600,…
    ## $ dep_delay      <dbl> 2, 4, 2, -1, -6, -4, -5, -3, -3, -2, -2, -2, -2, …
    ## $ arr_time       <int> 830, 850, 923, 1004, 812, 740, 913, 709, 838, 753…
    ## $ sched_arr_time <int> 819, 830, 850, 1022, 837, 728, 854, 723, 846, 745…
    ## $ arr_delay      <dbl> 11, 20, 33, -18, -25, 12, 19, -14, -8, 8, -2, -3,…
    ## $ carrier        <chr> "UA", "UA", "AA", "B6", "DL", "UA", "B6", "EV", "…
    ## $ flight         <int> 1545, 1714, 1141, 725, 461, 1696, 507, 5708, 79, …
    ## $ tailnum        <chr> "N14228", "N24211", "N619AA", "N804JB", "N668DN",…
    ## $ origin         <chr> "EWR", "LGA", "JFK", "JFK", "LGA", "EWR", "EWR", …
    ## $ dest           <chr> "IAH", "IAH", "MIA", "BQN", "ATL", "ORD", "FLL", …
    ## $ air_time       <dbl> 227, 227, 160, 183, 116, 150, 158, 53, 140, 138, …
    ## $ distance       <dbl> 1400, 1416, 1089, 1576, 762, 719, 1065, 229, 944,…
    ## $ hour           <dbl> 5, 5, 5, 5, 6, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 6…
    ## $ minute         <dbl> 15, 29, 40, 45, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    ## $ time_hour      <dttm> 2013-01-01 05:00:00, 2013-01-01 05:00:00, 2013-0…

#### 02-summarize()——————————————-

    by_tailnum <- group_by(flights, tailnum)
    delay <- summarise(by_tailnum,
                       count = n(),
                       dist = mean(distance, na.rm = TRUE),
                       delay = mean(arr_delay, na.rm = TRUE))
    delay <- filter(delay, count > 20, dist < 2000)

    # Interestingly, the average delay is only slightly related to the
    # average distance flown by a plane.
    ggplot(delay, aes(dist, delay)) +
            geom_point(aes(size = count), alpha = 1/2) +
            geom_smooth() +
            scale_size_area()

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 1 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](/home/jim/code/try_things_here/md/00007_Hadley_dplyr_vignette_2_semantics_files/figure-markdown_strict/unnamed-chunk-3-1.png)

#### 03-summarize() + aggregate functions() ————————

    # take vector (column), return single number
    destinations <- group_by(flights, dest)  #336776 x 19   
    summarise(destinations,
              planes = n_distinct(tailnum),   # number, not list
              flights = n()                   # number
    ) %>% head(3)

    ## # A tibble: 3 x 3
    ##   dest  planes flights
    ##   <chr>  <int>   <int>
    ## 1 ABQ      108     254
    ## 2 ACK       58     265
    ## 3 ALB      172     439

#### 03A-summarize() + aggregrage + rollup (skipped) —————

#### 04-selecting operations -Semantics —————————-

    # Definitions
    #       'Column names'  or 'column positions'
    #       'Bare variable names'
    #       'syntax - symbol to put where
    #       'semantics'  - meaning;  same symbol in select has different
    #       meaning in mutate

    #       '
    # tibble:   When referring to columns:   Position or column naame
    # works for select, not mutuate

#### 05-position vs bare column names ——————————

    flights %>% base::colnames()

    ##  [1] "year"           "month"          "day"            "dep_time"      
    ##  [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
    ##  [9] "arr_delay"      "carrier"        "flight"         "tailnum"       
    ## [13] "origin"         "dest"           "air_time"       "distance"      
    ## [17] "hour"           "minute"         "time_hour"

    ## SAME
    select(flights, year) %>% 
      head(3)   # Works (Column 1 = year, Column 5 = sched dep time)

    ## # A tibble: 3 x 1
    ##    year
    ##   <int>
    ## 1  2013
    ## 2  2013
    ## 3  2013

    select(flights, 1) %>% 
      head(3) # Works

    ## # A tibble: 3 x 1
    ##    year
    ##   <int>
    ## 1  2013
    ## 2  2013
    ## 3  2013

#### 06-context matters! ——————————————-

    ## Goal:  display  "sched_dep_time"    (col 5)

    select(flights,5) %>% 
      head(3) # Works

    ## # A tibble: 3 x 1
    ##   sched_dep_time
    ##            <int>
    ## 1            515
    ## 2            529
    ## 3            540

    # but ...       
    year<- 5   
    select(flights, year) %>% 
      head(3) # Fails, displays "year" (col 1)

    ## # A tibble: 3 x 1
    ##    year
    ##   <int>
    ## 1  2013
    ## 2  2013
    ## 3  2013

#### 06A-but ….helper function do NOT put the column names into scope

    ##  Display columns begin with dep
    select(flights, starts_with("dep")) %>% head(3)    # Works

    ## # A tibble: 3 x 2
    ##   dep_time dep_delay
    ##      <int>     <dbl>
    ## 1      517         2
    ## 2      533         4
    ## 3      542         2

    # but ..
    year <- "dep"
    select(flights, starts_with(year)) %>% head(3)     # still Works!

    ## # A tibble: 3 x 2
    ##   dep_time dep_delay
    ##      <int>     <dbl>
    ## 1      517         2
    ## 2      533         4
    ## 3      542         2

#### 07-sublties - identity() ———————————–

    # compare above to (identity returns argument, IN Context). 

    # identity forces evaluation BEFORE invoking all the column names!

    year <- 5
    select(flights, year, base::identity(year)) %>% head(3)     # Works, get col 1 (year) AND col 5 (sched_dep_time)

    ## # A tibble: 3 x 2
    ##    year sched_dep_time
    ##   <int>          <int>
    ## 1  2013            515
    ## 2  2013            529
    ## 3  2013            540

    ## 08-dplyr (>= 0.6) understands col names (as well as position)

    vars <- c("year","month")
    select(flights, vars, day,7) %>% head(3)     # Works, col7 = 'arrival time'

    ## Note: Using an external vector in selections is ambiguous.
    ## ℹ Use `all_of(vars)` instead of `vars` to silence this message.
    ## ℹ See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    ## This message is displayed once per session.

    ## # A tibble: 3 x 4
    ##    year month   day arr_time
    ##   <int> <int> <int>    <int>
    ## 1  2013     1     1      830
    ## 2  2013     1     1      850
    ## 3  2013     1     1      923

#### 09-!! ——————————————————–

    # identity() is useful, but UNSAFE   if var were really col name

    # unquote !!   is more general and safer:       
    # This tells dplyr to bypass the data frame and to directly look in the context: 

    flights$vars <- flights$year   
    flights %>% glimpse()  # vars

    ## Rows: 336,776
    ## Columns: 20
    ## $ year           <int> 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2…
    ## $ month          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ day            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ dep_time       <int> 517, 533, 542, 544, 554, 554, 555, 557, 557, 558,…
    ## $ sched_dep_time <int> 515, 529, 540, 545, 600, 558, 600, 600, 600, 600,…
    ## $ dep_delay      <dbl> 2, 4, 2, -1, -6, -4, -5, -3, -3, -2, -2, -2, -2, …
    ## $ arr_time       <int> 830, 850, 923, 1004, 812, 740, 913, 709, 838, 753…
    ## $ sched_arr_time <int> 819, 830, 850, 1022, 837, 728, 854, 723, 846, 745…
    ## $ arr_delay      <dbl> 11, 20, 33, -18, -25, 12, 19, -14, -8, 8, -2, -3,…
    ## $ carrier        <chr> "UA", "UA", "AA", "B6", "DL", "UA", "B6", "EV", "…
    ## $ flight         <int> 1545, 1714, 1141, 725, 461, 1696, 507, 5708, 79, …
    ## $ tailnum        <chr> "N14228", "N24211", "N619AA", "N804JB", "N668DN",…
    ## $ origin         <chr> "EWR", "LGA", "JFK", "JFK", "LGA", "EWR", "EWR", …
    ## $ dest           <chr> "IAH", "IAH", "MIA", "BQN", "ATL", "ORD", "FLL", …
    ## $ air_time       <dbl> 227, 227, 160, 183, 116, 150, 158, 53, 140, 138, …
    ## $ distance       <dbl> 1400, 1416, 1089, 1576, 762, 719, 1065, 229, 944,…
    ## $ hour           <dbl> 5, 5, 5, 5, 6, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 6…
    ## $ minute         <dbl> 15, 29, 40, 45, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    ## $ time_hour      <dttm> 2013-01-01 05:00:00, 2013-01-01 05:00:00, 2013-0…
    ## $ vars           <int> 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2…

    vars <- c("year","month","day")
    select(flights, !! vars) %>% head(3)        # Works! cols for year,month, day, not col 'vars'

    ## # A tibble: 3 x 3
    ##    year month   day
    ##   <int> <int> <int>
    ## 1  2013     1     1
    ## 2  2013     1     1
    ## 3  2013     1     1

    # just to be sure
    select(flights, !! vars, vars) %>% head(3)    # Works!  now includes col name 'vars'

    ## # A tibble: 3 x 4
    ##    year month   day  vars
    ##   <int> <int> <int> <int>
    ## 1  2013     1     1  2013
    ## 2  2013     1     1  2013
    ## 3  2013     1     1  2013

#### 10-MUTATE —————————————————–

    # rmarkdown::render("./007_Hadley_dplyr_vignette_2_semantics.R",
                      #output_format="pdf_document")

    # mutuate     need vector
    dim(flights)

    ## [1] 336776     20

    mutate(flights,year) %>% head(3)# ignores

    ## # A tibble: 3 x 20
    ##    year month   day dep_time sched_dep_time dep_delay arr_time
    ##   <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ## 1  2013     1     1      517            515         2      830
    ## 2  2013     1     1      533            529         4      850
    ## 3  2013     1     1      542            540         2      923
    ## # … with 13 more variables: sched_arr_time <int>, arr_delay <dbl>,
    ## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>,
    ## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>, vars <int>

    mutate(flights, 2) %>% head(3) # adds column "2"

    ## # A tibble: 3 x 21
    ##    year month   day dep_time sched_dep_time dep_delay arr_time
    ##   <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ## 1  2013     1     1      517            515         2      830
    ## 2  2013     1     1      533            529         4      850
    ## 3  2013     1     1      542            540         2      923
    ## # … with 14 more variables: sched_arr_time <int>, arr_delay <dbl>,
    ## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>,
    ## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>, vars <int>, 2 <dbl>

    mutate(flights,"year",2) %>% head(3) # adds both

    ## # A tibble: 3 x 22
    ##    year month   day dep_time sched_dep_time dep_delay arr_time
    ##   <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ## 1  2013     1     1      517            515         2      830
    ## 2  2013     1     1      533            529         4      850
    ## 3  2013     1     1      542            540         2      923
    ## # … with 15 more variables: sched_arr_time <int>, arr_delay <dbl>,
    ## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>,
    ## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>, vars <int>, "year" <chr>, 2 <dbl>

    mutate(flights, year+10) %>% head(3)

    ## # A tibble: 3 x 21
    ##    year month   day dep_time sched_dep_time dep_delay arr_time
    ##   <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ## 1  2013     1     1      517            515         2      830
    ## 2  2013     1     1      533            529         4      850
    ## 3  2013     1     1      542            540         2      923
    ## # … with 14 more variables: sched_arr_time <int>, arr_delay <dbl>,
    ## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>,
    ## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>, vars <int>, year + 10 <dbl>

    colnames(mutate(flights, year+10))  # doesn't save new column

    ##  [1] "year"           "month"          "day"            "dep_time"      
    ##  [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
    ##  [9] "arr_delay"      "carrier"        "flight"         "tailnum"       
    ## [13] "origin"         "dest"           "air_time"       "distance"      
    ## [17] "hour"           "minute"         "time_hour"      "vars"          
    ## [21] "year + 10"

    colnames(flights)

    ##  [1] "year"           "month"          "day"            "dep_time"      
    ##  [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
    ##  [9] "arr_delay"      "carrier"        "flight"         "tailnum"       
    ## [13] "origin"         "dest"           "air_time"       "distance"      
    ## [17] "hour"           "minute"         "time_hour"      "vars"

    select(flights, "year+10")

    ## Error: Can't subset columns that don't exist.
    ## ✖ Column `year+10` doesn't exist.

    var <- seq(1:nrow(flights))
    length(var)

    ## [1] 336776

    ## get confused!

    # demands a vector!
    flights$day %>% row_number() %>% head(3)

    ## [1] 1 2 3

    # behave like []
    flights$day %>% min() #1

    ## [1] 1

    flights$day %>% max() # 31

    ## [1] 31

    flights$day %>% row_number() %>% max()   # 336776

    ## [1] 336776

    # STOP --------------------------------------
