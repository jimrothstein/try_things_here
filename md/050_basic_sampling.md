
vim:linebreak:nowrap:nospell:cul tw=78 fo=tqlnr foldcolumn=3
------------------------------------------------------------

title: “050A\_basic\_samping” output: html\_document: highlight:
pygments theme: cerulean toc: yes editor\_options: chunk\_output\_type:
console —

Basic sampling,
---------------

-   Verbs: sample, rep, repetition
-   Collect all examples HERE
-   [source Rafal Chapter
    14:](https://rafalab.github.io/dsbook/probability.html#discrete-probability)

<!--  RENDER:  see bottom -->
replicate vector

    # return a vector, containing x  3 times (3 elments)
    rep(x=5,times = 3)  # 5 5 5 
          ## [1] 5 5 5

    # return vector of "j" "k"  6 times (12 elements)
    v <- rep(x=letters[10:11], times=6)

generate seq

    seq(from = 1, to = 10, by=0.1)
          ##  [1]  1.0  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9  2.0  2.1  2.2  2.3  2.4
          ## [16]  2.5  2.6  2.7  2.8  2.9  3.0  3.1  3.2  3.3  3.4  3.5  3.6  3.7  3.8  3.9
          ## [31]  4.0  4.1  4.2  4.3  4.4  4.5  4.6  4.7  4.8  4.9  5.0  5.1  5.2  5.3  5.4
          ## [46]  5.5  5.6  5.7  5.8  5.9  6.0  6.1  6.2  6.3  6.4  6.5  6.6  6.7  6.8  6.9
          ## [61]  7.0  7.1  7.2  7.3  7.4  7.5  7.6  7.7  7.8  7.9  8.0  8.1  8.2  8.3  8.4
          ## [76]  8.5  8.6  8.7  8.8  8.9  9.0  9.1  9.2  9.3  9.4  9.5  9.6  9.7  9.8  9.9
          ## [91] 10.0

    x <- seq(1:10)
    x
          ##  [1]  1  2  3  4  5  6  7  8  9 10
    rep(x, 3) # 1...10 1 ...10  1...10
          ##  [1]  1  2  3  4  5  6  7  8  9 10  1  2  3  4  5  6  7  8  9 10  1  2  3  4  5  6
          ## [27]  7  8  9 10

take a sample, returns vector

    sample(x=c(0,1), size= 7, replace=TRUE)
          ## [1] 1 1 1 1 0 1 1

    sample(x=c("blue","red"), size=20, replace=TRUE, prob=c(0.8,0.2))
          ##  [1] "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue"
          ## [12] "blue" "blue" "red"  "blue" "blue" "red"  "red"  "red"  "blue"

    # note:
    m <- matrix(data=1:100, nrow=25) # fills 1st column, then second ...
    head(m)
          ##      [,1] [,2] [,3] [,4]
          ## [1,]    1   26   51   76
          ## [2,]    2   27   52   77
          ## [3,]    3   28   53   78
          ## [4,]    4   29   54   79
          ## [5,]    5   30   55   80
          ## [6,]    6   31   56   81

    # find all 7 or 11
    sample(1:6,2)
          ## [1] 3 1

game

    # game:  roll 2 dice, 7 or 11?
    # construct matrix of 2 cols, so simulate throwing 2 die, 50x.

    B  <- 50  # experiments (rows)
    n  <- 2   # each experment, 2 dice

    s <- sample(1:6,B*n, replace=TRUE) # returns vector
    m <- matrix(s, nrow= B, ncol=n)
    head(m)
          ##      [,1] [,2]
          ## [1,]    4    4
          ## [2,]    3    6
          ## [3,]    2    5
          ## [4,]    6    6
          ## [5,]    5    1
          ## [6,]    3    4


    #### 0050_from_norm
    df <- data.frame(matrix(rnorm(1000), ncol =10))
    head(df)    
          ##       X1     X2     X3      X4     X5       X6     X7     X8     X9     X10
          ## 1  1.796 -0.508  0.463 -2.3356  0.904 -0.17321 -0.856 -0.338 -1.047 -0.1896
          ## 2  0.684  1.448  0.803 -1.1840  0.498 -0.58276  0.655  0.270 -0.803 -0.2615
          ## 3  0.627 -0.608 -1.487  2.0501  0.182 -0.18522  0.351 -0.298 -1.041 -1.1297
          ## 4 -0.425  0.282  0.902 -0.6745  1.160  0.00474  1.461  0.475  1.494  1.3079
          ## 5  2.066 -0.186 -0.695 -0.7566  1.739 -0.32256 -0.579  1.165 -0.844  0.0487
          ## 6 -0.822  0.587 -0.209  0.0768 -1.029  0.29129  0.407 -0.171  2.437 -1.3023

    N  <- 10000
    roll <- sample(x=c(-1,1),size=N,replace=TRUE, prob=c(0.5,0.5))
    roll  <- as.integer(roll)
    is_integer(roll)
          ## [1] TRUE
    is_vector(roll)# T
          ## [1] TRUE
    is_atomic(roll)
          ## [1] TRUE
    str(roll)
          ##  int [1:10000] -1 1 -1 1 1 1 -1 -1 1 1 ...


    t  <- tibble(raw =roll,
             cum_total = cumsum(raw))
          ## Error in tibble(raw = roll, cum_total = cumsum(raw)): could not find function "tibble"
    print(t, n=20)
          ## Error in print.default(x, useSource = useSource, ...): invalid 'na.print' specification
    tail(t)
          ##                 
          ## 1 function (x)  
          ## 2 UseMethod("t")
    plot( x=1:N, y=t$cum_total)
          ## Error in t$cum_total: object of type 'closure' is not subsettable



    #### 0060_coin_flip_running_avg
    # 1/n converges slowly!
    size <- 100000
    t <- tibble(x=sample(x=c(1,0),size=size, replace = TRUE),
                run_avg = dplyr::cummean(x)
                ) %>% 
        mutate(line = 1:size)
          ## Error in tibble(x = sample(x = c(1, 0), size = size, replace = TRUE), : could not find function "tibble"

    t %>% head()
          ##                 
          ## 1 function (x)  
          ## 2 UseMethod("t")

    t$run_avg %>% tail()
          ## Error in t$run_avg: object of type 'closure' is not subsettable
    t %>% ggplot(aes(x=line, y=run_avg)) +
        geom_point()
          ## Error in ggplot(., aes(x = line, y = run_avg)): could not find function "ggplot"
        

    # create 'urn' with 5 balls
    beads <- rep(c("red", "blue"), times = c(2,3))
    beads
          ## [1] "red"  "red"  "blue" "blue" "blue"

    # pick sample (of 1)
    event <- sample(beads,size=1)
    event
          ## [1] "red"

    # many events
    set.seed(2012)
    B <- 10000
    events <- replicate(B,sample(beads,size=1))
    table(events)  #  5988 blue, 4012 blue
          ## events
          ## blue  red 
          ## 5953 4047
    t <- tibble(events)
          ## Error in tibble(events): could not find function "tibble"
        
    # shortcut...
    events1 <- sample(beads, size = B, replace = TRUE)
    table(events1)  # 5988, 4012
          ## events1
          ## blue  red 
          ## 6054 3946

    x <- rnorm(10000,0,1)
    mean(x <= 0)  # cute,  returns area, percentile
          ## [1] 0.502

    knitr::knit_exit() 
