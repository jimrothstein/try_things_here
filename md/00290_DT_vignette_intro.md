### Vignette for data.table


    REF: [http://rdatatable.github.io](rdatatable)
    ##      Vignette:  Intro
    ##      example(data.table)

    library(magrittr)
    library(data.table)
    citation("data.table")

    ## 
    ## To cite package 'data.table' in publications use:
    ## 
    ##   Matt Dowle and Arun Srinivasan (2021). data.table:
    ##   Extension of `data.frame`. R package version
    ##   1.14.0.
    ##   https://CRAN.R-project.org/package=data.table
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Manual{,
    ##     title = {data.table: Extension of `data.frame`},
    ##     author = {Matt Dowle and Arun Srinivasan},
    ##     year = {2021},
    ##     note = {R package version 1.14.0},
    ##     url = {https://CRAN.R-project.org/package=data.table},
    ##   }

    input <- if (file.exists("./data/flights14.csv")) {
       "data/flights14.csv"
    } else {
      "https://raw.githubusercontent.com/Rdatatable/data.table/master/vignettes/flights14.csv"

      #saveRDS("flights14.csv", "data/flights14.csv")
    }
    # 2.2 MM
    flights <- fread(input)
    head(flights)

    ##    year month day dep_delay arr_delay carrier origin dest
    ## 1: 2014     1   1        14        13      AA    JFK  LAX
    ## 2: 2014     1   1        -3        13      AA    JFK  LAX
    ## 3: 2014     1   1         2         9      AA    JFK  LAX
    ## 4: 2014     1   1        -8       -26      AA    LGA  PBI
    ## 5: 2014     1   1         2         1      AA    JFK  LAX
    ## 6: 2014     1   1         4         0      AA    EWR  LAX
    ##    air_time distance hour
    ## 1:      359     2475    9
    ## 2:      363     2475   11
    ## 3:      351     2475   19
    ## 4:      157     1035    7
    ## 5:      350     2475   13
    ## 6:      339     2454   18

### examine dt

    # I'm lazy!  use DT[]
    DT <- flights
    colnames(flights)

    ##  [1] "year"      "month"     "day"       "dep_delay"
    ##  [5] "arr_delay" "carrier"   "origin"    "dest"     
    ##  [9] "air_time"  "distance"  "hour"

    typeof(flights) #list

    ## [1] "list"

    class(flights) # df AND "data.table"

    ## [1] "data.table" "data.frame"

    dplyr::glimpse(flights)

    ## Rows: 253,316
    ## Columns: 11
    ## $ year      <int> 2014, 2014, 2014, 2014, 2014, 2014, 201…
    ## $ month     <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
    ## $ day       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
    ## $ dep_delay <int> 14, -3, 2, -8, 2, 4, -2, -3, -1, -2, -5…
    ## $ arr_delay <int> 13, 13, 9, -26, 1, 0, -18, -14, -17, -1…
    ## $ carrier   <chr> "AA", "AA", "AA", "AA", "AA", "AA", "AA…
    ## $ origin    <chr> "JFK", "JFK", "JFK", "LGA", "JFK", "EWR…
    ## $ dest      <chr> "LAX", "LAX", "LAX", "PBI", "LAX", "LAX…
    ## $ air_time  <int> 359, 363, 351, 157, 350, 339, 338, 356,…
    ## $ distance  <int> 2475, 2475, 2475, 1035, 2475, 2454, 247…
    ## $ hour      <int> 9, 11, 19, 7, 13, 18, 21, 15, 15, 18, 1…

    # convert df
    # DT <- as.data.table(df)

### Basic

    # =========================================
    # BASIC:    WHERE, SELECT, GROUP BY (sql)
    # =========================================
    # WHERE clause( subset)  -------------------## 
    flights [origin == "JFK" & carrier == "AA" & year == "2014" & month == 6L ] %>% nrow()

    ## [1] 1257

    head( flights[order(origin)])

    ##    year month day dep_delay arr_delay carrier origin dest
    ## 1: 2014     1   1         4         0      AA    EWR  LAX
    ## 2: 2014     1   1        -5       -17      AA    EWR  MIA
    ## 3: 2014     1   1       191       185      AA    EWR  DFW
    ## 4: 2014     1   1        -1        -2      AA    EWR  DFW
    ## 5: 2014     1   1        -3       -10      AA    EWR  MIA
    ## 6: 2014     1   1         4       -17      AA    EWR  DFW
    ##    air_time distance hour
    ## 1:      339     2454   18
    ## 2:      161     1085   16
    ## 3:      214     1372   16
    ## 4:      214     1372   14
    ## 5:      154     1085    6
    ## 6:      215     1372    9

     flights[order(origin)] %>% nrow() %>% head()

    ## [1] 253316

    # group, total
    DT[,.N,by=origin]

    ##    origin     N
    ## 1:    JFK 81483
    ## 2:    LGA 84433
    ## 3:    EWR 87400

    # reverse order!
    DT[order(-origin), .N, by=origin]

    ##    origin     N
    ## 1:    LGA 84433
    ## 2:    JFK 81483
    ## 3:    EWR 87400

    head( flights[order(-origin)] )

    ##    year month day dep_delay arr_delay carrier origin dest
    ## 1: 2014     1   1        -8       -26      AA    LGA  PBI
    ## 2: 2014     1   1        -7        -6      AA    LGA  ORD
    ## 3: 2014     1   1        -7         0      AA    LGA  ORD
    ## 4: 2014     1   1        -8       -17      AA    LGA  ORD
    ## 5: 2014     1   1        -2        15      AA    LGA  ORD
    ## 6: 2014     1   1        -3         1      AA    LGA  ORD
    ##    air_time distance hour
    ## 1:      157     1035    7
    ## 2:      142      733    5
    ## 3:      143      733    6
    ## 4:      139      733    6
    ## 5:      145      733    7
    ## 6:      139      733    8

    # return a vector -------------------## 
    head (flights[, arr_delay])

    ## [1]  13  13   9 -26   1   0

    # return a list -----------------##
    head (flights[, list(arr_delay)])

    ##    arr_delay
    ## 1:        13
    ## 2:        13
    ## 3:         9
    ## 4:       -26
    ## 5:         1
    ## 6:         0

    head (flights[, .(arr_delay)])   # .( )  alias for list

    ##    arr_delay
    ## 1:        13
    ## 2:        13
    ## 3:         9
    ## 4:       -26
    ## 5:         1
    ## 6:         0

    # ========
    # SELECT
    # ========
    flights[,mean(arr_delay)]

    ## [1] 8.15

    flights[,mean(arr_delay), by = dest]

    ##      dest     V1
    ##   1:  LAX   4.80
    ##   2:  PBI   8.77
    ##   3:  MIA   1.92
    ##   4:  SEA   3.84
    ##   5:  SFO   6.45
    ##  ---            
    ## 105:  ANC   2.69
    ## 106:  TVC  23.66
    ## 107:  HYA  -1.17
    ## 108:  SBN  -5.62
    ## 109:  DAL -16.00

    flights[origin == "JFK" && 1:5,mean(arr_delay), by = dest]

    ##      dest     V1
    ##   1:  LAX   4.80
    ##   2:  PBI   8.77
    ##   3:  MIA   1.92
    ##   4:  SEA   3.84
    ##   5:  SFO   6.45
    ##  ---            
    ## 105:  ANC   2.69
    ## 106:  TVC  23.66
    ## 107:  HYA  -1.17
    ## 108:  SBN  -5.62
    ## 109:  DAL -16.00

    # wrong:  why giving me first & last 5?
    flights[origin == "JFK" && 1:5,mean(arr_delay), by = dest]

    ##      dest     V1
    ##   1:  LAX   4.80
    ##   2:  PBI   8.77
    ##   3:  MIA   1.92
    ##   4:  SEA   3.84
    ##   5:  SFO   6.45
    ##  ---            
    ## 105:  ANC   2.69
    ## 106:  TVC  23.66
    ## 107:  HYA  -1.17
    ## 108:  SBN  -5.62
    ## 109:  DAL -16.00

    # why is orgin EWR appear?
    flights[origin == "JFK" && 1:5 ,.(origin,mean(arr_delay)), by = dest]

    ##         dest origin    V2
    ##      1:  LAX    JFK   4.8
    ##      2:  LAX    JFK   4.8
    ##      3:  LAX    JFK   4.8
    ##      4:  LAX    JFK   4.8
    ##      5:  LAX    EWR   4.8
    ##     ---                  
    ## 253312:  DAL    LGA -16.0
    ## 253313:  DAL    LGA -16.0
    ## 253314:  DAL    LGA -16.0
    ## 253315:  DAL    LGA -16.0
    ## 253316:  DAL    LGA -16.0

    # SELECT 3 coluns, 1 is calc -----------------##
    # CHAIN, in desc order
    flights[,.(arr_delay,dep_delay,totl = arr_delay + dep_delay)] [order(-totl)]

    ##         arr_delay dep_delay totl
    ##      1:      1494      1498 2992
    ##      2:      1223      1241 2464
    ##      3:      1090      1087 2177
    ##      4:      1115      1056 2171
    ##      5:      1064      1071 2135
    ##     ---                         
    ## 253312:       -72        -9  -81
    ## 253313:       -63       -18  -81
    ## 253314:       -79        -5  -84
    ## 253315:       -70       -21  -91
    ## 253316:      -112      -112 -224

    # CHAIN
    flights[,.(arr_delay,dep_delay,totl = arr_delay + dep_delay)] [totl <0,]

    ##         arr_delay dep_delay totl
    ##      1:       -26        -8  -34
    ##      2:       -18        -2  -20
    ##      3:       -14        -3  -17
    ##      4:       -17        -1  -18
    ##      5:       -14        -2  -16
    ##     ---                         
    ## 141810:       -14         3  -11
    ## 141811:       -27        10  -17
    ## 141812:       -30         1  -29
    ## 141813:       -14        -5  -19
    ## 141814:         1        -5   -4

    # SELECT when sum is less 0
    flights[sum(arr_delay+dep_delay) <0,] 

    ## Empty data.table (0 rows and 11 cols): year,month,day,dep_delay,arr_delay,carrier...

    # WHERE (ie subset) and SELECT length of subset -----------------##
    flights[origin == "JFK" & month==6L, length(dest)]

    ## [1] 8422

    # shortcut .N   -----------------##
    flights[origin == "JFK" & month==6L, .N] 

    ## [1] 8422

### Group

    # GROUP
    flights[,.N, by=dest]  # # rows by dest

    ##      dest     N
    ##   1:  LAX 14434
    ##   2:  PBI  5543
    ##   3:  MIA  9928
    ##   4:  SEA  3179
    ##   5:  SFO 11907
    ##  ---           
    ## 105:  ANC    13
    ## 106:  TVC    56
    ## 107:  HYA    75
    ## 108:  SBN     8
    ## 109:  DAL    15

    # ==========
    # FOR LOOP
    # ==========

    df <- data.frame(x=rnorm(100))
    dt  <- as.data.table(df)

    # each row i, set new col v = i
    for(i in 1:100)dt[i, v := i]
    head(dt)

    ##         x v
    ## 1:  0.853 1
    ## 2:  1.453 2
    ## 3: -2.394 3
    ## 4: -0.510 4
    ## 5: -1.445 5
    ## 6:  0.804 6
