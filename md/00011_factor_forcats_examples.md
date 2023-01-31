     vim:linebreak:nowrap:nospell:cul tw=78 fo=tqlnr foldcolumn=3 

<!-- 
set cul   "cursorline
cc=+1           "colorcolumn is 1 more than tw

vim: to format all urls for md
s/https.*/[&]()/g
-->

    print(file)

          ## [1] "00011_factor_forcats_examples.Rmd"

from Grolemund - categorical variables Ref:
<https://rstudio-education.github.io/hopr/r-objects.html> Ch 5.5.2

> To make a factor, pass an atomic vector into the factor function. R
> will recode the data in the vector as integers and store the results
> in an integer vector. R will also add a levels attribute to the
> integer, which contains a set of labels for displaying the factor
> values, and a class attribute, which contains the class factor:

    # recode chr[] as integer
    gender <- factor(c("male", "female", "female", "male"))

    typeof(gender)
          ## [1] "integer"
    attributes(gender)   # levels, class
          ## $levels
          ## [1] "female" "male"  
          ## 
          ## $class
          ## [1] "factor"

    # internally, stored as integer
    unclass(gender)  # as  integers, with level attr
          ## [1] 2 1 1 2
          ## attr(,"levels")
          ## [1] "female" "male"


    # R uses the levels attribute when it displays the factor, as you will see.

    # displays as levels
    gender
          ## [1] male   female female male  
          ## Levels: female male

#### 0050\_factors (r4ds: Chapter 15, forcats)

#### factor: Peng, think ints with each having a label

    # create factors
    levels <- c("a","b")

    # "c" becomes "NA"  NO ERROR
    x <- c("a","b","b","b","c")

    x <- c("a","b","b","b")  # chr[]


    # factor: closer look
    # store as integer, use levels for display
    y <- factor(x, levels=levels)
    y
          ## [1] a b b b
          ## Levels: a b

    typeof(y)
          ## [1] "integer"
    attributes(y)  # levels, class 
          ## $levels
          ## [1] "a" "b"
          ## 
          ## $class
          ## [1] "factor"

    # also

    levels(y)
          ## [1] "a" "b"
    class(y)
          ## [1] "factor"
    str(y)
          ##  Factor w/ 2 levels "a","b": 1 2 2 2

    # nice features
    table(y)
          ## y
          ## a b 
          ## 1 3
    names(y)
          ## NULL
    labels(y)
          ## [1] "1" "2" "3" "4"

    unclass(y)  # underneath, stored as ints
          ## [1] 1 2 2 2
          ## attr(,"levels")
          ## [1] "a" "b"
    names(unclass(y))
          ## NULL
    labels(unclass(y))
          ## [1] "1" "2" "3" "4"

\#\#\#\#10\_base sort

    # create data another way
    x <- rep(c("a","b"),6)  # chr[]
    x

          ##  [1] "a" "b" "a" "b" "a" "b" "a" "b" "a" "b" "a" "b"

    # turn into factora
    levels=c("a","b")
    y <- factor(x, levels=levels)
    y

          ##  [1] a b a b a b a b a b a b
          ## Levels: a b

    sort(y)  # sort the underlying ints, then display with levels

          ##  [1] a a a a a a b b b b b b
          ## Levels: a b

<https://forcats.tidyverse.org/index.html> \#\#\#\# forcats::fct\_\*

    # create random data from 0:9
    x <- 0:9
    x

          ##  [1] 0 1 2 3 4 5 6 7 8 9

    # Create sample of 100 by:
    # Choose 1 value from x, then replace it.
    # Repeat 100 times

    set.seed(2021)
    y <- sample(x, size=100, replace=TRUE)
    y  # int[100]

          ##   [1] 6 5 9 6 3 5 5 5 4 6 8 6 2 1 2 7 9 3 4 5 1 2 3 4 5 4 8 5 1 1 5 5 5 1
          ##  [35] 5 1 0 7 0 5 4 3 3 7 2 2 1 0 7 9 8 8 0 8 7 0 3 5 1 8 2 1 4 9 5 5 5 7
          ##  [69] 0 4 2 8 8 6 5 3 6 0 2 0 3 8 2 0 8 9 7 0 4 4 2 9 6 8 6 2 3 6 0 4

    # only change is create factor
    z <- factor(y, levels=0:9)
    z

          ##   [1] 6 5 9 6 3 5 5 5 4 6 8 6 2 1 2 7 9 3 4 5 1 2 3 4 5 4 8 5 1 1 5 5 5 1
          ##  [35] 5 1 0 7 0 5 4 3 3 7 2 2 1 0 7 9 8 8 0 8 7 0 3 5 1 8 2 1 4 9 5 5 5 7
          ##  [69] 0 4 2 8 8 6 5 3 6 0 2 0 3 8 2 0 8 9 7 0 4 4 2 9 6 8 6 2 3 6 0 4
          ## Levels: 0 1 2 3 4 5 6 7 8 9

    # nice freq table  5 is most common (17)
    table(z)  

          ## z
          ##  0  1  2  3  4  5  6  7  8  9 
          ## 11  9 11  9 10 17  9  7 11  6

    ####
    # Data internally or display, does not change, added class and levels
    # Only change:  order of factors
    ####

    # order factors by freq
    forcats::fct_infreq(z)

          ##   [1] 6 5 9 6 3 5 5 5 4 6 8 6 2 1 2 7 9 3 4 5 1 2 3 4 5 4 8 5 1 1 5 5 5 1
          ##  [35] 5 1 0 7 0 5 4 3 3 7 2 2 1 0 7 9 8 8 0 8 7 0 3 5 1 8 2 1 4 9 5 5 5 7
          ##  [69] 0 4 2 8 8 6 5 3 6 0 2 0 3 8 2 0 8 9 7 0 4 4 2 9 6 8 6 2 3 6 0 4
          ## Levels: 5 0 2 8 4 1 3 6 7 9

    # keep largest 3, lump rest into "other"
    forcats::fct_lump(z, n=3)

          ##   [1] Other 5     Other Other Other 5     5     5     Other Other 8    
          ##  [12] Other 2     Other 2     Other Other Other Other 5     Other 2    
          ##  [23] Other Other 5     Other 8     5     Other Other 5     5     5    
          ##  [34] Other 5     Other 0     Other 0     5     Other Other Other Other
          ##  [45] 2     2     Other 0     Other Other 8     8     0     8     Other
          ##  [56] 0     Other 5     Other 8     2     Other Other Other 5     5    
          ##  [67] 5     Other 0     Other 2     8     8     Other 5     Other Other
          ##  [78] 0     2     0     Other 8     2     0     8     Other Other 0    
          ##  [89] Other Other 2     Other Other 8     Other 2     Other Other 0    
          ## [100] Other
          ## Levels: 0 2 5 8 Other

    forcats::fct_lump(z, n=3, other_level = "Z")

          ##   [1] Z 5 Z Z Z 5 5 5 Z Z 8 Z 2 Z 2 Z Z Z Z 5 Z 2 Z Z 5 Z 8 5 Z Z 5 5 5 Z
          ##  [35] 5 Z 0 Z 0 5 Z Z Z Z 2 2 Z 0 Z Z 8 8 0 8 Z 0 Z 5 Z 8 2 Z Z Z 5 5 5 Z
          ##  [69] 0 Z 2 8 8 Z 5 Z Z 0 2 0 Z 8 2 0 8 Z Z 0 Z Z 2 Z Z 8 Z 2 Z Z 0 Z
          ## Levels: 0 2 5 8 Z

    # order factors by 1st appearance 6 5 ...
    forcats::fct_inorder(z)

          ##   [1] 6 5 9 6 3 5 5 5 4 6 8 6 2 1 2 7 9 3 4 5 1 2 3 4 5 4 8 5 1 1 5 5 5 1
          ##  [35] 5 1 0 7 0 5 4 3 3 7 2 2 1 0 7 9 8 8 0 8 7 0 3 5 1 8 2 1 4 9 5 5 5 7
          ##  [69] 0 4 2 8 8 6 5 3 6 0 2 0 3 8 2 0 8 9 7 0 4 4 2 9 6 8 6 2 3 6 0 4
          ## Levels: 6 5 9 3 4 8 2 1 7 0

    # shuffle, again no change to underlying data or display, only factors
    forcats::fct_shuffle(z)

          ##   [1] 6 5 9 6 3 5 5 5 4 6 8 6 2 1 2 7 9 3 4 5 1 2 3 4 5 4 8 5 1 1 5 5 5 1
          ##  [35] 5 1 0 7 0 5 4 3 3 7 2 2 1 0 7 9 8 8 0 8 7 0 3 5 1 8 2 1 4 9 5 5 5 7
          ##  [69] 0 4 2 8 8 6 5 3 6 0 2 0 3 8 2 0 8 9 7 0 4 4 2 9 6 8 6 2 3 6 0 4
          ## Levels: 6 0 2 3 8 4 1 9 5 7

    # again
    a  <- forcats::fct_shuffle(z)
    a

          ##   [1] 6 5 9 6 3 5 5 5 4 6 8 6 2 1 2 7 9 3 4 5 1 2 3 4 5 4 8 5 1 1 5 5 5 1
          ##  [35] 5 1 0 7 0 5 4 3 3 7 2 2 1 0 7 9 8 8 0 8 7 0 3 5 1 8 2 1 4 9 5 5 5 7
          ##  [69] 0 4 2 8 8 6 5 3 6 0 2 0 3 8 2 0 8 9 7 0 4 4 2 9 6 8 6 2 3 6 0 4
          ## Levels: 6 4 7 1 2 8 9 3 5 0

    f <- factor(c("a", "b", "c"))
    f

          ## [1] a b c
          ## Levels: a b c

    fct_rev(f) #> [1] a b c

          ## [1] a b c
          ## Levels: c b a

    g  <- fct_rev(f)
    g

          ## [1] a b c
          ## Levels: c b a

    levels(g)

          ## [1] "c" "b" "a"

    fct_inseq(g)

          ## Error: At least one existing level must be coercible to numeric.

## Begin examples from FORCATS:: cheat sheet

    library(forcats)
    f <- base::factor(c("a", "c", "b", "a"),
     levels = c("a", "b", "c")) 
    f

          ## [1] a c b a
          ## Levels: a b c

    levels(f)

          ## [1] "a" "b" "c"

    unclass(f) # structure

          ## [1] 1 3 2 1
          ## attr(,"levels")
          ## [1] "a" "b" "c"

    fct_count(f)

          ## # A tibble: 3 x 2
          ##   f         n
          ##   <fct> <int>
          ## 1 a         2
          ## 2 b         1
          ## 3 c         1

    fct_count(f, sort = FALSE  )

          ## # A tibble: 3 x 2
          ##   f         n
          ##   <fct> <int>
          ## 1 a         2
          ## 2 b         1
          ## 3 c         1

    fct_unique(f)

          ## [1] a b c
          ## Levels: a b c

Concatenate data

    f1 <- factor(c("a", "c"))
    f1

          ## [1] a c
          ## Levels: a c

    f2 <- factor(c("b", "a"))
    f2

          ## [1] b a
          ## Levels: a b

    fct_c(f1, f2)

          ## [1] a c b a
          ## Levels: a c b

manually, reorder factors

    fct_relevel(f, c("b", "c", "a"))

          ## [1] a c b a
          ## Levels: b c a

highest is first

    f

          ## [1] a c b a
          ## Levels: a b c

    fct_infreq(f)

          ## [1] a c b a
          ## Levels: a b c

    f3 <- factor(c("c", "c", "a"))
    f3

          ## [1] c c a
          ## Levels: a c

    fct_infreq(f3) 

          ## [1] c c a
          ## Levels: c a

set factors in order of appearance in data

    f2

          ## [1] b a
          ## Levels: a b

    fct_inorder(f2)

          ## [1] b a
          ## Levels: b a

fct\_reorder

    str(iris)  # Species is categorical (factor)

          ## 'data.frame':  150 obs. of  5 variables:
          ##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
          ##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
          ##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
          ##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
          ##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

    # initial ordering
    levels(iris$Species)

          ## [1] "setosa"     "versicolor" "virginica"

    head(iris$Species, n = 20L)

          ##  [1] setosa setosa setosa setosa setosa setosa setosa setosa setosa setosa
          ## [11] setosa setosa setosa setosa setosa setosa setosa setosa setosa setosa
          ## Levels: setosa versicolor virginica

    pdf("~/Downloads/print_and_delete/forcats.pdf")
    #plot(x, r, col = 2, ylim = c(-5, 5))
    # abline(h = 0)
    boxplot(data = iris, Sepal.Width ~ Species)
    # boxplot(data = iris, Sepal.Width ~ fct_reorder(Species, Sepal.Width)) 
    dev.off()

          ## png 
          ##   2

## Redo boxplot but in asc or desc order

    # .f = factor
    # for each .f, group .x (a variable) and apply .fun 
    # sort based on .fun(.x) in asc order 
    # fct_reorder(.f, .x, .fun=median, .desc = FALSE)

    f   <- iris$Species # a factor
    x   <- iris$Sepal.Width
    library(dplyr)

    x  <- fct_reorder(iris$Species, iris$Sepal.Width)
    levels(x)

          ## [1] "versicolor" "virginica"  "setosa"

    pdf("~/Downloads/print_and_delete/forcats.pdf")
    boxplot(data = iris, Sepal.Width ~ fct_reorder(Species, Sepal.Width)) 
    dev.off()

          ## png 
          ##   2

------------------------------------------------------------------------

/newpage

    # TODO:  file is found when knitr runs (see above)

    # file must be of form:
    # dir/name_of_this_file    where dir is relative to project root

    file  <- here("", "")
    file

    # in general, pdf will look nicer
    rmarkdown::render(file,
                      #output_format = "pdf_document",
                      output_format = "html_document",
                      output_file = "~/Downloads/print_and_delete/out")
