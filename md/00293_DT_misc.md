REF:
<https://stackoverflow.com/questions/47917614/use-equivalent-of-purrrmap-to-iterate-through-data-table?noredirect=1&lq=1>

-   This code is without purrr::
-   But original code was using data.table, magrittr, and purrr::
-   Don’t even look at purrr:: version, this is so much simpler!

<!-- -->

    # dput(Input_File)

    Input_File  <- structure(list(  
                   Zone = c("East", "East", "East", "East", "East", 
    "East", "East", "West", "West", "West", "West", "West", "West", 
    "West"), 
                   Fiscal.Year = c(2016, 2016, 2016, 2016, 2016, 2016, 
    2017, 2016, 2016, 2016, 2017, 2017, 2018, 2018), 
                   Transaction.ID = c(132, 
    133, 134, 135, 136, 137, 171, 171, 172, 173, 175, 176, 177, 178
    ), 
                   L.Rev = c(3, 0, 0, 1, 0, 0, 2, 1, 1, 2, 2, 1, 2, 1), L.Qty = c(3, 
    0, 0, 1, 0, 0, 1, 1, 1, 2, 2, 1, 2, 1), A.Rev = c(0, 0, 0, 1, 
    1, 1, 0, 0, 0, 0, 0, 1, 0, 0), A.Qty = c(0, 0, 0, 2, 2, 3, 0, 
    0, 0, 0, 0, 3, 0, 0), 
                   I.Rev = c(4, 4, 4, 0, 1, 0, 3, 0, 0, 0, 1, 0, 1, 1), 
                   I.Qty = c(2, 2, 2, 0, 1, 0, 3, 0, 0, 0, 1, 0, 1, 1)
                   ), 
                   .Names = c("Zone", "Fiscal.Year", "Transaction.ID", "L.Rev", 
    "L.Qty", "A.Rev", "A.Qty", "I.Rev", "I.Qty"), 
                   row.names = c(NA, 14L), 
                   class = "data.frame")

    Input_File

          ##    Zone Fiscal.Year Transaction.ID L.Rev L.Qty A.Rev A.Qty
          ## 1  East        2016            132     3     3     0     0
          ## 2  East        2016            133     0     0     0     0
          ## 3  East        2016            134     0     0     0     0
          ## 4  East        2016            135     1     1     1     2
          ## 5  East        2016            136     0     0     1     2
          ## 6  East        2016            137     0     0     1     3
          ## 7  East        2017            171     2     1     0     0
          ## 8  West        2016            171     1     1     0     0
          ## 9  West        2016            172     1     1     0     0
          ## 10 West        2016            173     2     2     0     0
          ## 11 West        2017            175     2     2     0     0
          ## 12 West        2017            176     1     1     1     3
          ## 13 West        2018            177     2     2     0     0
          ## 14 West        2018            178     1     1     0     0
          ##    I.Rev I.Qty
          ## 1      4     2
          ## 2      4     2
          ## 3      4     2
          ## 4      0     0
          ## 5      1     1
          ## 6      0     0
          ## 7      3     3
          ## 8      0     0
          ## 9      0     0
          ## 10     0     0
          ## 11     1     1
          ## 12     0     0
          ## 13     1     1
          ## 14     1     1

    library(data.table)

    # group on 2 columns, sum 1 column; return NEW DT
    setDT(Input_File)[, .(sum = sum(L.Rev)), by = .(Zone, Fiscal.Year)]

          ##    Zone Fiscal.Year sum
          ## 1: East        2016   4
          ## 2: East        2017   2
          ## 3: West        2016   4
          ## 4: West        2017   3
          ## 5: West        2018   3

### List\_columns, Starwars

    library(dplyr)
    library(data.table)

    # list of lists
    sw  <- as.data.table(dplyr::starwars)

    # 14 names
    names(sw)

          ##  [1] "name"       "height"     "mass"       "hair_color"
          ##  [5] "skin_color" "eye_color"  "birth_year" "sex"       
          ##  [9] "gender"     "homeworld"  "species"    "films"     
          ## [13] "vehicles"   "starships"

    # use films only
    films  <- sw$films

    # 87, each holds chr[]
    length(films)

          ## [1] 87

    head(films)

          ## [[1]]
          ## [1] "The Empire Strikes Back" "Revenge of the Sith"    
          ## [3] "Return of the Jedi"      "A New Hope"             
          ## [5] "The Force Awakens"      
          ## 
          ## [[2]]
          ## [1] "The Empire Strikes Back" "Attack of the Clones"   
          ## [3] "The Phantom Menace"      "Revenge of the Sith"    
          ## [5] "Return of the Jedi"      "A New Hope"             
          ## 
          ## [[3]]
          ## [1] "The Empire Strikes Back" "Attack of the Clones"   
          ## [3] "The Phantom Menace"      "Revenge of the Sith"    
          ## [5] "Return of the Jedi"      "A New Hope"             
          ## [7] "The Force Awakens"      
          ## 
          ## [[4]]
          ## [1] "The Empire Strikes Back" "Revenge of the Sith"    
          ## [3] "Return of the Jedi"      "A New Hope"             
          ## 
          ## [[5]]
          ## [1] "The Empire Strikes Back" "Revenge of the Sith"    
          ## [3] "Return of the Jedi"      "A New Hope"             
          ## [5] "The Force Awakens"      
          ## 
          ## [[6]]
          ## [1] "Attack of the Clones" "Revenge of the Sith" 
          ## [3] "A New Hope"

    films[[1]]

          ## [1] "The Empire Strikes Back" "Revenge of the Sith"    
          ## [3] "Return of the Jedi"      "A New Hope"             
          ## [5] "The Force Awakens"

    sw  <- sw[, .(films = films[[1]]),
              by = c(...)]

          ## Error in eval(bysub, parent.frame(), parent.frame()): '...' used in an incorrect context

    # normalized!
    sw  <- sw[, .(films = films[[1]]),
              by = c("name")]
    sw

          ##                name                   films
          ##   1: Luke Skywalker The Empire Strikes Back
          ##   2: Luke Skywalker     Revenge of the Sith
          ##   3: Luke Skywalker      Return of the Jedi
          ##   4: Luke Skywalker              A New Hope
          ##   5: Luke Skywalker       The Force Awakens
          ##  ---                                       
          ## 169:            BB8       The Force Awakens
          ## 170: Captain Phasma       The Force Awakens
          ## 171:  Padmé Amidala    Attack of the Clones
          ## 172:  Padmé Amidala      The Phantom Menace
          ## 173:  Padmé Amidala     Revenge of the Sith

### Using for loop, to create new column (modify-in-place)

    df <- data.frame(x=rnorm(100))
    dt  <- as.data.table(df)
    head(dt)

          ##          x
          ## 1:  0.8460
          ## 2: -0.6586
          ## 3:  1.6106
          ## 4:  0.0327
          ## 5:  0.9896
          ## 6:  0.3644

    # each row i, set new col v = i (in place)
    for(i in 1:100)dt[i, v := i]
    head(dt)

          ##          x v
          ## 1:  0.8460 1
          ## 2: -0.6586 2
          ## 3:  1.6106 3
          ## 4:  0.0327 4
          ## 5:  0.9896 5
          ## 6:  0.3644 6

------------------------------------------------------------------------
